require 'ffaker'

FactoryGirl.define do
  factory :shipment do
    name FFaker::Company.name
    price 15
    description 'test shipment'
  end
end