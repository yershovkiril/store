require_relative 'features_helper'

feature 'Checkout' do
  given(:book) { create(:book) }
  given!(:country) { create(:country) }
  given!(:shipment) { create(:shipment) }
  given(:address) { create(:address, country: country) }
  
  context 'step address' do
    scenario 'user can filling in billing and shipping address' do
      add_book_to_cart(book)
      
      click_on('Checkout')
      fill_in_address_for('billing')
      click_on('Save and continue')
      
      expect(page).to have_content('Shipping methods')
      expect(page).to have_current_path(checkout_path(:delivery))
    end
  end
  
  context 'step delivery' do
    scenario 'user can choose delivery company' do
      add_book_to_cart(book)
      
      click_on('Checkout')
      fill_in_address_for('billing')
      click_on('Save and continue')
      
      choose('checkout_form[shipment_id]')
      click_on('Save and continue')
      
      expect(page).to have_content('Credit Card')
      expect(page).to have_current_path(checkout_path(:payment))
    end
  end
  
  context 'step credit card' do
    scenario 'user can filling in credit card info' do
      add_book_to_cart(book)
      
      click_on('Checkout')
      fill_in_address_for('billing')
      click_on('Save and continue')
      
      choose('checkout_form[shipment_id]')
      click_on('Save and continue')
      
      fill_in_credit_card
      click_on('Save and continue')
      
      expect(page).to have_current_path(checkout_path(:confirm))
    end
  end
  
  context 'step confirm' do
    scenario 'user can place order' do
      add_book_to_cart(book)
      
      click_on('Checkout')
      fill_in_address_for('billing')
      click_on('Save and continue')
      
      choose('checkout_form[shipment_id]')
      click_on('Save and continue')
      
      fill_in_credit_card
      click_on('Save and continue')
      
      click_on('Place Order')
      
      expect(page).to have_current_path(checkout_path(:complete))
    end
  end
  
  context 'step complete' do
    scenario 'user can see the order details' do
            add_book_to_cart(book)
      
      click_on('Checkout')
      fill_in_address_for('billing')
      click_on('Save and continue')
      
      choose('checkout_form[shipment_id]')
      click_on('Save and continue')
      
      fill_in_credit_card
      click_on('Save and continue')
      
      click_on('Place Order')
      
      expect(page).to have_content('Shipping address')
      expect(page).to have_content('Billing address')
      expect(page).to have_content('Shipments')
      expect(page).to have_content('Payment Information')
    end
  end
end
