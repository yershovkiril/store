class CreateOrderBooks < ActiveRecord::Migration
  def change
    create_table :order_books do |t|
      t.decimal     :price, precision: 8, scale: 2
      t.integer     :quantity
      t.references  :book, foreign_key: true, index: true
      t.references  :order, foreign_key: true, index: true
      
      t.timestamps null: false
    end
  end
end
