class UsersController < ApplicationController
  before_action :authenticate_user!
  
  def edit
  end

  def update
    assign_address_to_user
    if current_user.update(user_params)
      flash[:notice] = t('user.flashes.account_updated')
      redirect_to edit_user_path
    else
      render :edit
    end
  end
  
  private
  
  def assign_address_to_user
    case user_params.keys[0]
    when 'billing_address_attributes'
      current_user.billing_address ? current_user.billing_address.delete : ''
      current_user.billing_address = Address.create(user_params['billing_address_attributes'])
    when 'shipping_address_attributes'
      current_user.shipping_address ? current_user.shipping_address.delete : ''
      current_user.shipping_address = Address.create(user_params['shipping_address_attributes'])
    end
  end

  def user_params
    params.require(:user).permit(
      :email, :password, :password_confirmation, :current_password,
      billing_address_attributes: address_attributes,
      shipping_address_attributes: address_attributes
    )
  end
  
  def address_attributes
    %i(id first_name last_name address zip city phone country_id)
  end
end
