require 'rails_helper'

RSpec.describe Book, type: :model do
  
  context "validations" do 
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:price) }
    it { is_expected.to validate_presence_of(:in_stock) }
  end
  
  context "associations" do
    it { is_expected.to have_many(:author) }
    it { is_expected.to belong_to(:category) }
    it { is_expected.to have_many(:reviews) }
    it { is_expected.to have_many(:order_books) }
  end
  
  describe "best_books" do
    let(:book) { FactoryGirl.create(:book_with_order, quantity: 2) }
    let(:book1) { FactoryGirl.create(:book_with_order) }

    it 'returns books ordered descending by order_books' do
      expect(Book.best_books).to eq([book, book1])
    end
  end
  
end
