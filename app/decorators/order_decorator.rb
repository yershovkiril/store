class OrderDecorator < Draper::Decorator
  include Draper::LazyHelpers
  
  delegate_all
  delegate :last_numbers, :expiration_date, to: :credit_card, prefix: true

  decorates_association :credit_card
  decorates_association :shipment
  decorates_association :shipping_address
  decorates_association :billing_address
  decorates_association :order_items
  
  def name_supplier
    Shipment.find(object.shipment_id).name
  end
end
