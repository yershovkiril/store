FactoryGirl.define do
  factory :order do
    ref 'R856999'
    completed_at nil
    shipment nil
    
    factory :order_with_coupon do
      coupon
    end
  end
end
