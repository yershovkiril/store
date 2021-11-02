FactoryGirl.define do
  factory :coupon do
    code 'QWERTY'
    starts_at { Date.new(2015, 7, 1) }
    expires_at { Date.new(2017, 7, 1) }
    discount 5
  end
end
