class OrderCalculation
  def initialize(order)
    @order = order
  end

  delegate :order_books, :shipment, :coupon, to: :order

  def books_total
    order_books.inject(0) { |a, e| a + (e.price * e.quantity) }
  end

  def shipment_total
    shipment = Shipment.find_by(id: @order.shipment_id)
    shipment ? shipment.price : 0
  end

  def discount
    coupon ? coupon.discount : 0
  end

  def total
    books_total + shipment_total - discount
  end

  private

  attr_reader :order
end
