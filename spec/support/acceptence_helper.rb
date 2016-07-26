module AcceptenceHelper
  def sign_in(user)
    visit new_user_session_path
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    click_on 'Log in'
  end
  
  def mock_auth_hash(email = 'new@user.com')
    OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new(
      provider: 'facebook',
      uid: '1235456',
      info: { email: email }
    )
  end
  
  def add_book_to_cart(book)
    visit(book_path(book))
    click_on('ADD TO CART')
  end
  
  def fill_in_address_for(address_type)
    address = "checkout_form_#{address_type}_address_attributes"
    fill_in "#{address}_first_name", with: FFaker::Name.first_name
    fill_in "#{address}_last_name", with: FFaker::Name.last_name
    fill_in "#{address}_address", with: FFaker::Address.street_address
    fill_in "#{address}_city", with: FFaker::Address.city
    fill_in "#{address}_zip", with: FFaker::AddressUS.zip_code
    fill_in "#{address}_phone", with: FFaker::PhoneNumber.phone_number
    select country.name, from: "#{address}_country_id"
  end
  
  def fill_in_credit_card
    fill_in 'Card number', with: '1111111111111111'
    select '12', from: 'checkout_form_credit_card_attributes_exp_month'
    select '2020', from: 'checkout_form_credit_card_attributes_exp_year'
    fill_in 'CVV code', with: '123'
  end
end