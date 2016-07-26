require 'rails_helper'
require 'spec_helper'
 

RSpec.describe User, type: :model do
  context "validations" do 
    it { is_expected.to validate_presence_of(:email) }
    
  end
  
  context "associations" do 
    it { is_expected.to have_many(:orders) }
    it { is_expected.to have_many(:reviews) }
    it { is_expected.to belong_to(:billing_address) }
    it { is_expected.to belong_to(:shipping_address) }
  end
  
  describe '#billing_address' do
    it "return new address if user.billing_address is nil" do 
      expect(subject.billing_address).to be_a(Address)
    end
    
    it "return current address if user already has one" do
      address = FactoryGirl.create(:address)
      user = FactoryGirl.create(:user, billing_address: address)
      expect(user.billing_address).to eq(address)
    end
  end
  
  describe '#shipping_address' do
    it 'return new address if user.shipping_address is nil' do 
      expect(subject.shipping_address).to be_a(Address)
    end
    
    it 'return current address if user already has one' do
      address = FactoryGirl.create(:address)
      user = FactoryGirl.create(:user, shipping_address: address)
      expect(user.shipping_address).to eq(address)
    end
  end
  
  describe '.from_omniauth (facebook)' do
    let(:auth) do
      OmniAuth::AuthHash.new(
        provider: 'facebook',
        uid: '123456',
        info: { email: 'new@user.com' }
      )
    end
    
    context 'user already has uid and provider' do 
      it "returns user" do 
        user_with_uid = FactoryGirl.create(:user, provider: 'facebook', uid: '123456')
        expect(User.from_omniauth(auth)).to eq(user_with_uid)
      end
    end
    
    context 'user has not assign uid' do 
      let!(:user) { FactoryGirl.create(:user) }
      
      context 'user does not exist' do 
        it 'creates new user in db' do 
          expect { User.from_omniauth(auth) }.to change(User, :count).by(1)
        end
        
        it 'resturn new user' do 
          expect(User.from_omniauth(auth)).to be_a(User)
        end
        
        it 'write user email' do
          user = User.from_omniauth(auth)
          expect(user.email).to eq(auth.info[:email])
        end
        
        it 'write uid and provider' do
          user = User.from_omniauth(auth)
          expect(user.uid).to eq(auth.uid)
          expect(user.provider).to eq(auth.provider)
        end
        
      end
    end
  end

end
