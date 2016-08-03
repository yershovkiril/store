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
      click_on(I18n.t('checkout.next_step'))
      
      expect(page).to have_content(I18n.t('checkout.ship_methods'))
      expect(page).to have_current_path(checkout_path(:delivery))
    end
  end
  
  context 'step delivery' do
    scenario 'user can choose delivery company' do
      add_book_to_cart(book)
      
      click_on('Checkout')
      fill_in_address_for('billing')
      click_on(I18n.t('checkout.next_step'))
      
      choose('checkout_form[shipment_id]')
      click_on(I18n.t('checkout.next_step'))
      
      expect(page).to have_content(I18n.t('checkout.credit_card'))
      expect(page).to have_current_path(checkout_path(:payment))
    end
  end
  
  context 'step credit card' do
    scenario 'user can filling in credit card info' do
      add_book_to_cart(book)
      
      click_on('Checkout')
      fill_in_address_for('billing')
      click_on(I18n.t('checkout.next_step'))
      
      choose('checkout_form[shipment_id]')
      click_on(I18n.t('checkout.next_step'))
      
      fill_in_credit_card
      click_on(I18n.t('checkout.next_step'))
      
      expect(page).to have_current_path(checkout_path(:confirm))
    end
  end
  
  context 'step confirm' do
    scenario 'user can place order' do
      add_book_to_cart(book)
      
      click_on('Checkout')
      fill_in_address_for('billing')
      click_on(I18n.t('checkout.next_step'))
      
      choose('checkout_form[shipment_id]')
      click_on(I18n.t('checkout.next_step'))
      
      fill_in_credit_card
      click_on(I18n.t('checkout.next_step'))
      
      click_on(I18n.t('checkout.place_order'))
      
      expect(page).to have_current_path(checkout_path(:complete))
    end
  end
  
  context 'step complete' do
    scenario 'user can see the order details' do
            add_book_to_cart(book)
      
      click_on(I18n.t('checkout.checkout'))
      fill_in_address_for('billing')
      click_on(I18n.t('checkout.next_step'))
      
      choose('checkout_form[shipment_id]')
      click_on(I18n.t('checkout.next_step'))
      
      fill_in_credit_card
      click_on(I18n.t('checkout.next_step'))
      
      click_on(I18n.t('checkout.place_order'))
      
      expect(page).to have_content(I18n.t('checkout.shipping_address'))
      expect(page).to have_content(I18n.t('checkout.billing_address'))
      expect(page).to have_content(I18n.t('checkout.shipments'))
      expect(page).to have_content(I18n.t('checkout.payment_info'))
    end
  end
end
