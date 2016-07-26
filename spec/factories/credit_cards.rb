require 'ffaker'

FactoryGirl.define do
  factory :credit_card do
    number "1234567812345678"
    cvv "695"
    exp_month "11"
    exp_year "2019"
    firstname FFaker::Name.first_name
    lastname FFaker::Name.last_name
  end
end
