require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  before do 
    sign_in FactoryGirl.create(:user)
  end
  
  describe 'GET #edit' do
    before { get :edit }
    
    it 'assigns user' do
      expect(assigns(:user)).not_to be_nil
    end
    
    it 'render edit view' do
      expect(response).to render_template(:edit)
    end
  end
  
  describe 'GET #show' do
    it 'assign history' do
      allow(OrderHistory).to receive(:new).and_return(double('history'))
      get :show
      expect(assigns(:history)).not_to be_nil
    end
    
    it 'renders show view' do
      get :show
      expect(response).to render_template(:show)
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
      it 'assigns user' do
        expect(assigns(:user)).not_to be_nil
      end
      
      it 'receives update for user' do
        expect(user).to have_received(:update)
      end
      
      it 'sends success notice' do
        put :update, user: user_params
        expect(flash[:notice]).to eq 'Account was successfully updated.'
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
  
  describe 'PATCH #update_password' do
    let(:user) { FactoryGirl.build(:user) }
    let(:user_params) { FactoryGirl.attributes_for(:user) }
    
    before do
      allow(controller).to receive(:current_user).and_return(user)
      allow(user).to receive(:update_with_password).and_return(true)
      patch :update_password, user: user_params
    end
    
    context 'with valid attributes' do
      it 'assigns user' do
        expect(assigns(:user)).not_to be_nil
      end
      
      it 'receives update for user' do
        expect(user).to have_received(:update_with_password)
      end
      
      it 'sends success notice' do
        expect(flash[:notice]).to eq 'Password was successfully updated.'
      end
      
      it 'redirect to settings page' do
        expect(response).to redirect_to edit_user_path
      end
    end
    
    context 'with valid attributes' do
      before do
        allow(controller).to receive(:current_user).and_return(user)
        allow(user).to receive(:update_with_password).and_return(false)
        patch :update_password, user: user_params
      end
      
      it 'renders :edit view' do
        expect(response).to render_template :edit
      end
    end
  end
  
end
