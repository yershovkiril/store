class CreateShipments < ActiveRecord::Migration
  def change
    create_table :shipments do |t|
      t.string  :name
      t.decimal :price,       precision: 8, scale: 2
      t.string  :description
      
      t.timestamps null: false
    end
  end
end
