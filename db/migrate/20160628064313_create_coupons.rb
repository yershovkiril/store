class CreateCoupons < ActiveRecord::Migration
  def change
    create_table :coupons do |t|
      t.string  :code
      t.date    :expires_at
      t.date    :starts_at
      t.decimal :discount, precision: 8, scale: 2, default: 0.0

      t.timestamps null: false
    end
  end
end
