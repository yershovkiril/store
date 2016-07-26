FactoryGirl.define do
  factory :review do
    text_review FFaker::Lorem.paragraph
    rating 5
    approved false
    book
    
    factory :invalid_review do
      text_review ''
    end
  end
end
