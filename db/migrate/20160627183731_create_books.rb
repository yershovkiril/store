class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string  :title
      t.text    :description
      t.decimal :price,            precision: 8, scale: 2
      t.integer :in_stock
      t.text    :full_description
      t.string  :image
      
      t.timestamps null: false
    end
  end
end
