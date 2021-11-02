class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string     :first_name
      t.string     :last_name
      t.string     :address
      t.string     :city
      t.integer    :zip
      t.string     :phone
      t.references :country, foreign_key: true, index: true
      
      t.timestamps null: false
    end
  end
end
