require 'ffaker'

FactoryGirl.define do
  factory :book do
    title FFaker::Product.product_name
    description FFaker::Lorem.paragraph
    price 5.5
    in_stock 15
    category nil
    
    factory :book_with_order do
      transient do
        quantity 1
        author_id FactoryGirl.create(:author, first_name: 'Test_name', last_name: 'Test_name')
      end
      
      after(:create) do |book, evaluator| 
        FactoryGirl.create(:order_book, book: book, quantity: evaluator.quantity)
      end
    end
  end
end
