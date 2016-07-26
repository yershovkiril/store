class AddUserToOrders < ActiveRecord::Migration
  def change
    add_reference :orders, :user, index: true, foreign_key: true
    add_reference :orders, :credit_card, index: true, foreign_key: true
    add_reference :orders, :coupon, index: true, foreign_key: true
  end
end
