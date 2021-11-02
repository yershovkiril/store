require 'rails_helper'

RSpec.describe Address, type: :model do
  context "validations" do 
    it { is_expected.to validate_presence_of(:first_name) }
    it { is_expected.to validate_presence_of(:last_name) }
    it { is_expected.to validate_presence_of(:address) }
    it { is_expected.to validate_presence_of(:zip) }
    it { is_expected.to validate_presence_of(:city) }
    it { is_expected.to validate_presence_of(:phone) }
    it { is_expected.to validate_presence_of(:country) }
    it { should allow_value('+380631234567').for(:phone) }
    it { should_not allow_value("foo").for(:phone) }
    it { should allow_value('123').for(:zip) }
    it { should_not allow_value("foo").for(:zip) }
  end
  
  context "associations" do
    it { is_expected.to belong_to(:country) }
  end
end