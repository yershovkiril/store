class OrderHistory
  def initialize(user)
    @user = user
  end

  def orders_in_progress
    orders.in_progress.decorate
  end

  def orders_in_queue
    orders.in_queue.where("ref IS NOT NULL").decorate
  end

  def orders_in_delivery
    orders.in_delivery.decorate
  end

  def orders_delivered
    orders.delivered.decorate
  end

  private

  def orders
    @user.orders
  end
end
