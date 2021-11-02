class CheckoutController < ApplicationController
  include Wicked::Wizard

  before_action :check_order
  before_action :change_status_order, only: [:show]
  after_action :set_maximum_step, only: [:update]
  before_action :set_default_step

  steps :address, :delivery, :payment, :confirm, :complete

  def show
    @checkout_form = CheckoutForm.new(checkout_form_params)
    @order = order_in_progress.decorate
    render_wizard
  end

  def update
    @checkout_form = CheckoutForm.new(checkout_form_params)
    if @checkout_form.save
      redirect_path = future_step?(get_max_step) ? wizard_path(get_max_step) : next_wizard_path 
      redirect_to redirect_path
    else
      render_wizard
    end
  end

  private
  
  def change_status_order
    return unless step == :complete
    order_in_progress.create_order!
    session[:order_id] = nil
    cookies[:max_step] = :address
  end
  
  def set_default_step
    cookies[:max_step] ||= :address
  end
  
  def get_max_step
    cookies[:max_step].to_sym
  end

  def set_maximum_step
    max_index = wizard_steps.index(get_max_step)
    current_index = wizard_steps.index(step)
    cookies[:max_step] = wizard_steps[max_index + 1] if max_index.eql? current_index
  end
  
  def check_order
    redirect_to cart_path if order_in_progress.empty?
  end

  def address_attributes
    %i(id first_name last_name address zip city phone country_id)
  end

  def checkout_form_params
    params.fetch(:checkout_form, {})
          .permit(
            :use_billing,
            :shipment_id,
            billing_address_attributes: address_attributes,
            shipping_address_attributes: address_attributes,
            credit_card_attributes: [:number, :exp_month, :exp_year, :cvv])
          .merge(
            order: order_in_progress,
            step: step)
  end
end
