class Book < ActiveRecord::Base
  validates :title, :price, :in_stock, presence: true
  delegate  :full_name, to: :author, prefix: true, allow_nil: true
  
  has_many :author
  belongs_to :category
  has_many :reviews
  has_many :order_books
  
  mount_uploader :image, ImageUploader  
  paginates_per 12

  def self.best_books
    joins(:order_books)
      .select('books.*, sum(order_books.quantity) as qty')
      .group(:id)
      .order('qty DESC')
  end

end
