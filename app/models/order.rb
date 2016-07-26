class Order < ActiveRecord::Base
  include AASM
  
  belongs_to :user
  belongs_to :credit_card
  belongs_to :billing_address,  class_name: 'Address'
  belongs_to :shipping_address, class_name: 'Address'
  belongs_to :shipment
  belongs_to :coupon
  has_many   :order_books, dependent: :destroy
  
  accepts_nested_attributes_for :order_books
  
  validates :state, presence: true
  
  before_validation :set_coupon, if: 'code.present?'
  after_update :update_order
  
  attr_accessor :code
  
  delegate :clear, :empty?, to: :order_books
  delegate :discount,       to: :coupon,      prefix: true, allow_nil: true
  
  aasm column: :state, whiny_transitions: false do
    state :in_progress, initial: true
    state :in_queue, after_enter: :set_time_and_ref
    state :in_delivery
    state :delivered
    state :canceled
    
    event :create_order do
      transitions from: :in_progress, to: :in_queue
    end
    
    event :shipment do
      transitions from: :in_queue, to: :in_delivery
    end
    
    event :shipped do
      transitions from: :in_delivery, to: :delivered
    end

    event :reject do
      transitions from: [:in_progress, :in_queue], to: :canceled
    end    
  end
  
  def self.in_progress
    find_by(state: 'in_progress')
  end
    
  def add_to_order(book, quantity = 1)
    order_book = order_books.find_by(book: book)
    if order_book
      order_book.quantity += quantity
      order_book.save
    else
      order_books.create(price: book.price, quantity: quantity, book: book)
    end
    update_order
  end
  
  def update_order
    update_columns(
      total: calculate_price.total,
      subtotal: calculate_price.books_total,
      shipment_total: calculate_price.shipment_total
    )
  end
  
  def set_time_and_ref
    touch(:completed_at)  
    update(ref: ref_order)
  end
  
  def set_coupon
    coupon = Coupon.find_by(code: code)
    if coupon && coupon.active?
      self.coupon_id = coupon.id
    else
      errors.add(:base, 'Invalid coupon code')
    end
  end
  
  private
  
  def ref_order
    'R-%.6d' % id
  end
  
  def calculate_price
    @calculator ||= OrderCalculation.new(self)
  end
end