require 'rails_helper'

RSpec.describe Users::PasswordsController, type: :controller do
  before do 
    sign_in FactoryGirl.create(:user)
  end
  
  describe 'PATCH #update_password' do
    let(:user) { FactoryGirl.build(:user) }
    let(:user_params) { FactoryGirl.attributes_for(:user) }
    
    before do
      allow(controller).to receive(:current_user).and_return(user)
      allow(user).to receive(:update_with_password).and_return(true)
      @request.env["devise.mapping"] = Devise.mappings[:user]
      patch 'update', user: user_params
    end
    
    context 'with valid attributes' do
      it 'receives update for user' do
        expect(user).to have_received(:update_with_password)
      end
      
      it 'sends success notice' do
        expect(flash[:notice]).to eq I18n.t('user.flashes.password_updated')
      end
      
      it 'redirect to settings page' do
        expect(response).to redirect_to edit_user_path
      end
    end
    
    context 'with valid attributes' do
      before do
        allow(controller).to receive(:current_user).and_return(user)
        allow(user).to receive(:update_with_password).and_return(false)
        patch :update, user: user_params
      end
      
      it 'renders :edit view' do
        expect(response).to render_template :edit
      end
    end
  end
end
