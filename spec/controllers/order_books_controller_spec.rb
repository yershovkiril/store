require 'rails_helper'

RSpec.describe OrderBooksController, type: :controller do
  let!(:order_book) { FactoryGirl.create(:order_book) }
  
  describe 'DELETE #destroy' do
    it 'delete book from order' do
      expect {
        delete :destroy, id: order_book.id    
      }.to change(OrderBook, :count).by(-1)
    end
    
    it 'redirect to cart' do
      delete :destroy, id: order_book.id
      expect(response).to redirect_to(cart_path)
    end

  end
end
