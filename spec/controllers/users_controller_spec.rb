require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before do 
    sign_in FactoryGirl.create(:user)
  end
  
  describe 'GET #edit' do
    let(:user) { FactoryGirl.build(:user) }
    before { get :edit }
    
    it 'render edit view' do
      expect(response).to render_template(:edit)
    end
  end
  
  describe 'PATCH #update' do
    let(:user) { FactoryGirl.build(:user) }
    let(:user_params) { FactoryGirl.attributes_for(:user) }
    
    before do
      allow(controller).to receive(:current_user).and_return(user)
      allow(user).to receive(:update).and_return(true)
      patch :update, user: user_params
    end
    
    context 'with valid attributes' do
      it 'receives update for user' do
        expect(user).to have_received(:update)
      end
      
      it 'sends success notice' do
        put :update, user: user_params
        expect(flash[:notice]).to eq I18n.t('user.flashes.account_updated')
      end
      
      it 'redirect to settings page' do
        put :update, user: user_params
        expect(response).to redirect_to edit_user_path
      end
    end
    
    context 'with invalid attributes' do
      before do
        allow(controller).to receive(:current_user).and_return(user)
        allow(user).to receive(:update).and_return(false)
        patch :update, user: user_params
      end
      
      it 'render edit view' do
        expect(response).to render_template :edit
      end
    end
  end
end
