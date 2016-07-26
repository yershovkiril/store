class Review < ActiveRecord::Base
  belongs_to :book
  belongs_to :user
  
  validates :text_review, :rating, presence: true
  validates :rating, inclusion: { in: 1..5 }
end
