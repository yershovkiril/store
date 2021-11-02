class CreateCreditCards < ActiveRecord::Migration
  def change
    create_table :credit_cards do |t|
      t.string  :number
      t.string  :cvv
      t.string  :exp_month
      t.string  :exp_year
      t.string  :firstname
      t.string  :lastname

      t.timestamps null: false
    end
  end
end
