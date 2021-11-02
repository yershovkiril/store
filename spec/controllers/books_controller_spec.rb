require 'rails_helper'

RSpec.describe BooksController, type: :controller do
  let(:books) { FactoryGirl.create_list(:book, 2) }
  let(:book) { books.first }

  describe "GET #index" do
    before { get :index }
      
    it 'return array of books' do
      expect(assigns(:books)).to match_array(books)  
    end
      
    it 'render index view' do
      expect(response).to render_template(:index)
    end
  end

  describe "GET #show" do
    before { get 'show', id: book.id }
    
    it 'return book' do 
      expect(assigns(:book)).to eq(book)
    end
    
    it 'render show view' do
      expect(response).to render_template(:show)
    end
  end
end
