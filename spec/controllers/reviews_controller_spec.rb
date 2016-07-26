require 'rails_helper'

RSpec.describe ReviewsController, type: :controller do
  let!(:book) { FactoryGirl.create(:book) }
  before do 
    sign_in FactoryGirl.create(:user)
  end
  
  describe "GET #new" do
    before { get :new, book_id: book.id }

    it 'assigns @review' do
      expect(assigns(:review)).to be_a_new(Review)
    end
    
    it 'render new view' do
      expect(response).to render_template(:new)
    end
  end
  
  describe 'POST #create' do
    
    context 'save with valid attributes' do
      it 'save new review in the database' do
        expect {
          post :create, book_id: book, review: attributes_for(:review)
        }.to change(Review, :count).by(1)
      end
      
      it 'redirect to book page' do
        post :create, book_id: book, review: attributes_for(:review)
        expect(response).to redirect_to(book_path(book))
      end  
    end
    
    context 'save with not valid attributes' do
      it 'do not save new review in the database' do
        expect {
          post :create, book_id: book, review: attributes_for(:invalid_review)
        }.not_to change(Review, :count)
      end
      
      it 'render new view' do
        post :create, book_id: book, review: attributes_for(:invalid_review)
        expect(response).to render_template(:new)
      end 
    end
  end

end
