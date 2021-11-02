require_relative 'features_helper'

feature 'Cart' do
  given!(:book) { create(:book) }
  
  background do
    visit(book_path(book))
    click_on('ADD TO CART')
  end
  
  scenario 'user can remove book from cart' do
    find('.delete').click
    
    expect(page).to have_content('Your cart is empty')
    expect(page).to_not have_content(book.title)
    expect(page).to_not have_content(book.price)
  end
  
  scenario 'user can clear cart' do
    click_on('Empty cart')

    expect(page).to have_content('Your cart is empty')    
  end
  
  scenario 'user can use coupon and receive discount' do
    create(:coupon, discount: 5)
    
    fill_in('Coupon code', with: 'QWERTY')
    click_on('Update')
    expect(page).to have_content('Discount: $5')
  end
  
  scenario "user can't use not valid coupon" do
    fill_in('Coupon code', with: 'QWERTY11')
    click_on('Update')
    
    expect(page).to have_content('Invalid coupon code.')
  end
  
  scenario 'user can increase book quantity' do
    within('.table.cart') do
      fill_in('order[order_books_attributes][0][quantity]', with: '2')
    end
    
    click_on('Update')
    expect(page.find('#order_order_books_attributes_0_quantity').value).to eq('2')
  end
  
end
