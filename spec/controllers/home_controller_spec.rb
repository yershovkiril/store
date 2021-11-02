require 'rails_helper'

RSpec.describe HomeController, type: :controller do
  let(:book) { FactoryGirl.create(:book_with_order) }
  
  describe "GET #index" do
    before { get :index }
    
    it "returns array ob best_books" do
      expect(assigns(:best_books)).to match_array([book])
    end
    
    it 'render index view' do
      expect(response).to render_template(:index)
    end
  end

end
