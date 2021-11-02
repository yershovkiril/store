require 'rails_helper'

RSpec.describe Coupon do
  context 'associations' do
    it { is_expected.to have_many(:orders) }
  end
  
  describe "#active?" do
    it 'check coupon is active' do
      coupon = FactoryGirl.create('coupon', expires_at: Date.tomorrow)
      expect(coupon).to be_active
    end
    
    it 'check coupon is expire' do
      coupon = FactoryGirl.create('coupon', expires_at: Date.current-2)
      expect(coupon).not_to be_active
    end
  end
end
