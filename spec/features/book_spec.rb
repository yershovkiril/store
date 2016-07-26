require_relative 'features_helper'

feature 'Book' do
  given!(:book) { create(:book_with_order) }
  
  scenario 'user can viewed detail information about book' do
    visit(book_path(book))
    
    expect(page).to have_content(book.title)
    expect(page).to have_content(book.price)
    expect(page).to have_content(book.full_description)
  end
  
  scenario 'user can add book to shopping cart' do
    visit(book_path(book))
    
    click_on('ADD TO CART')
    
    expect(page).to have_current_path(cart_path)
    expect(page).to have_content(book.title)
    expect(page).to have_content(book.price)
  end
end