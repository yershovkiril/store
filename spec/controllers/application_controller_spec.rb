require 'rails_helper'
RSpec.describe ApplicationController do
  
  describe 'order_in_progress' do 
    context 'current_user exists' do
      let(:user) { FactoryGirl.create(:user) }
      
      before do
        allow(controller).to receive(:current_user) { user }
      end
      
      context 'user has order_in_progress' do
        it 'return order with state - in_progress' do 
          order = FactoryGirl.create(:order, user: user)
          expect(controller.order_in_progress).to eq(order)
        end
      end
      
      context 'user dont have order_in_progress' do
        let!(:order) { controller.order_in_progress }
        
        it 'assign order to user' do
          expect(order.user).to eq(user)
        end
        
        it 'save order_id in session' do
          expect(session[:order_id]).to eq(order.id)
        end
      end
      
      context 'find order without user (from session)' do
        let(:order) { FactoryGirl.create(:order) }
        
        it 'assign order to user' do 
          session[:order_id] = order.id
          order = controller.order_in_progress
          expect(order.user).to eq(user)  
        end
      end
      
    end
  end
end