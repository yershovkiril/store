require_relative 'features_helper'

feature 'User sign in' do
  context 'with credentials' do
    given(:user) { create(:user) }
    
    scenario 'Registered user try to sign in' do
      sign_in(user)
      
      expect(page).to have_content(I18n.t('devise.sessions.signed_in'))
      expect(page).to have_current_path(root_path)
    end
  
    scenario 'non-registered user try to sign in' do
      visit(new_user_session_path)
      
      fill_in('Email', with: 'wrong@test.com')
      fill_in('Password', with: '123456')
      click_on('Log in')
      
      expect(page).to have_content('Invalid Email or password')
      expect(page).to have_current_path(new_user_session_path)
    end
    
    scenario 'Authenticated user try to log out' do 
      sign_in(user)
      click_on('Sign out')
      
      expect(page).to have_content(I18n.t('devise.sessions.signed_out'))
    end
  end
  
  context 'with omniauth' do
    background do
      OmniAuth.config.test_mode = true
      visit(root_path)
    end
      
    scenario 'user can sign in via facebook' do
      mock_auth_hash

      click_on(I18n.t('sign_in'))
      expect(page).to have_content(I18n.t('devise.sign_in_facebook'))

      click_on(I18n.t('devise.sign_in_facebook'))
      expect(page).to have_content(I18n.t('devise.facebook_success'))
    end
    
    scenario 'with invalid credentials' do
      OmniAuth.config.mock_auth[:facebook] = :invalid_credentials

      click_on(I18n.t('sign_in'))
      click_on(I18n.t('devise.sign_in_facebook'))

      expect(page).to have_content(I18n.t('devise.facebook_error'))
    end
  end
end