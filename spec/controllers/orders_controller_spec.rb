require 'rails_helper'

RSpec.describe OrdersController, type: :controller do
  let(:order) { create(:order) }
  
  describe 'GET #show' do
    let(:user) { FactoryGirl.create(:user) }
    
    sign_in_user
    
    before do
      allow(controller).to receive(:current_user) { user }
      allow(user).to receive_message_chain(:orders, :find).and_return(order)
      get :show, id: order.id
    end
    
    it 'assigns order' do 
      expect(assigns(:order)).not_to be_nil  
    end
    
    it "renders :show view" do
      expect(response).to render_template :show
    end
  end
  
  describe 'GET #edit' do
    before do
      allow(controller).to receive_messages(order_in_progress: order)
      get :edit
    end
    
    it 'assigns order' do
      expect(assigns(:order)).to eq(order)
    end
    
    it 'render edit view' do
      expect(response).to render_template :edit
    end
  end
  
  describe 'POST #add_book' do
    let!(:book) { create(:book) }
    
    before do
      allow(controller).to receive(:order_in_progress) { order }
      allow(order).to receive(:add_to_order)
      post :add_book, book_id: book.id, order: { quantity: 1 }
    end
    
    it 'receives add_book' do
      expect(order).to have_received(:add_to_order).with(book, 1)
    end
    
    it 'redirect to cart' do
      expect(response).to redirect_to cart_path
    end
  end
  
  describe 'PATCH #update' do
    let(:order_params) { attributes_for(:order) }

    before do
      allow(controller).to receive(:order_in_progress) { order }
      allow(order).to receive(:update).and_return(true)
    end
    
    context 'with valid attributes' do
      it 'assigns order' do
        put :update, id: order.id, order: order_params
        expect(assigns(:order)).not_to be_nil
      end
      
      it 'receive update for orders' do 
        expect(order).to receive(:update)
        put :update, id: order.id, order: order_params
      end
      
      it 'redirect to cart' do
        put :update, id: order.id, order: order_params
        expect(response).to redirect_to cart_path
      end
      
      it 'redirect to checkout page if key is checkout' do
        put :update, id: order.id, order: order_params, checkout: true
        expect(response).to redirect_to checkout_index_path
      end
    end
    
    context 'with valid attributes' do
      it 'render edit view' do
        allow(order).to receive(:update).and_return(false)
        put :update, id: order.id, order: order_params, checkout: true
        expect(response).to render_template :edit
      end
    end
  end
  
  describe 'PATCH #empty' do
    before do
      allow(controller).to receive(:order_in_progress) { order }
    end
    
    it 'clear order' do
      expect(order).to receive(:clear)
      put :empty_cart
    end
    
    it 'redirect to cart page' do 
      put :empty_cart
      expect(response).to redirect_to(cart_path)
    end
  end
end
