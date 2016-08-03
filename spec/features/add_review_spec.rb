require_relative 'features_helper'

feature 'Add review' do
  given!(:book) { FactoryGirl.create(:book) }
  given(:user) { FactoryGirl.create(:user) }
  
  scenario 'authenticated user can add review' do
    sign_in(user)
    visit(book_path(book))
    click_on('Leave a Review')

    fill_in('Text review', with: 'Great book.')
    click_on('Add')
    
    expect(page).to have_content(I18n.t('review.flashes.created'))
  end
  
  scenario 'user try add not valid review' do
    sign_in(user)
    visit(book_path(book))
    click_on('Leave a Review')
    
    click_on('Add')
    
    expect(page).to have_content(I18n.t('review.flashes.error'))
  end
  
  scenario 'no login user tries to add review' do
    visit(book_path(book))
    click_on('Leave a Review')
    
    expect(page).to have_content(I18n.t('devise.failure.unauthenticated'))
  end
end