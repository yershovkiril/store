class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string   :ref
      t.decimal  :total,           precision: 8, scale: 2
      t.decimal  :subtotal,        precision: 8, scale: 2
      t.decimal  :shipment_total,  precision: 8, scale: 2
      t.string   :state,           default: 'in_progress'
      t.datetime :completed_at

      t.timestamps null: false

    end
  end
end
