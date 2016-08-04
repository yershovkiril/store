require 'ffaker'

FactoryGirl.define do
  factory :address, aliases: [:billing_address, :shipping_address] do
    first_name FFaker::Name.first_name
    last_name FFaker::Name.last_name
    address FFaker::Address.street_address
    zip FFaker::AddressUS.zip_code
    city FFaker::Address.city
    phone '+380631234567'
    country
  end
end
