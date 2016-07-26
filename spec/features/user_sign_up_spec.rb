require_relative 'features_helper'

feature 'User sign up' do
  scenario 'user try to sign up' do
    visit(root_path)
    
    click_on('Sign up')
    within('#new_user') do
      fill_in('Email', with: 'test_user@test.com')
      fill_in('Password', with: '123456')
      fill_in('Password confirmation', with: '123456')

      click_on('Sign up')
    end
    expect(page).to have_content('You have signed up successfully.')
  end
end