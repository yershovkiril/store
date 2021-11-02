require 'rails_helper'

RSpec.describe CategoriesController, type: :controller do
  
  let(:category) { FactoryGirl.create(:category) }
  let(:book) { FactoryGirl.create(:book, category: category) }
   
  describe 'GET #show' do
    before { get 'show', id: category.id }
    
    it 'return choose category by id' do
      expect(assigns(:category)).to eq(category)  
    end
    
    it 'return array of books by category' do
     expect(assigns(:books)).to eq([book])
    end
    
    it 'render show view' do
      expect(response).to render_template(:show)
    end
  end
end
