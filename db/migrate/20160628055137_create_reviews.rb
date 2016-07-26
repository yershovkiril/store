class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer   :rating
      t.text      :text_review
      t.boolean   :approved,    default: false, null: false
    
      t.timestamps null: false
    end
  end
end
