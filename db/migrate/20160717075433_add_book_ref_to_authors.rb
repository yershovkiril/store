class AddBookRefToAuthors < ActiveRecord::Migration
  def change
    add_reference :authors, :book, index: true, foreign_key: true
  end
end
