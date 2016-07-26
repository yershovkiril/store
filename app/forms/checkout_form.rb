class CheckoutForm
  include ActiveModel::Model

  attr_accessor :order,
                :step,
                :use_billing,
                :shipment_id,
                :billing_address_attributes,
                :shipping_address_attributes,
                :credit_card_attributes

  validate :create_errors

  def billing_address
    order.billing_address ||= order.user.try(:billing_address) || Address.new
  end

  def shipping_address
    order.shipping_address ||= order.user.try(:shipping_address) || Address.new
  end

  def credit_card
    order.credit_card ||= CreditCard.new
  end

  def save
    action_by_step
    return false unless valid?
    save_by_step
    order.save
  end

  private

  def action_by_step
    case step
    when :address then bind_address
    when :delivery then bind_delivery
    when :payment then bind_payment
    end
  end

  def save_by_step
    case step
    when :address then shipping_address.save && billing_address.save
    when :payment then credit_card.save
    end
  end

  def bind_address
    shipping_address.assign_attributes(shipping_address_attributes)
    billing_address.assign_attributes(billing_address_attributes)
    copy_billing_address if use_billing?
  end

  def bind_delivery
    order.shipment_id = shipment_id
  end

  def bind_payment
    credit_card.assign_attributes(credit_card_attributes)
  end

  def create_errors
    case step
    when :address
      add_errors(billing_address.errors) if billing_address.invalid?
      add_errors(shipping_address.errors) if shipping_address.invalid?
    when :payment
      add_errors(credit_card.errors) if credit_card.invalid?
    end
  end

  def add_errors(errors_items)
    errors_items.each do |attribute, message|
      errors.add(attribute, message)
    end
  end

  def use_billing?
    use_billing == '1'
  end

  def copy_billing_address
    if billing_address && shipping_address.nil?
      order.shipping_address = billing_address.clone
    else
      shipping_address.attributes = billing_address_attributes.except('id')
    end
  end
end
