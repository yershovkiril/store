require_relative 'features_helper'

feature 'Categories' do
  given!(:web) { create(:category, name: 'Web development') }
  given!(:history) { create(:category, name: 'History') }
  given!(:book) { create(:book, category: web) }
  
  scenario 'user can see the list of all categories' do
    visit(books_path)
    
    expect(page).to have_css('a', text: 'Web development')
    expect(page).to have_css('a', text: 'History')
  end

  scenario "user can see books by category" do
    visit(books_path)
    click_on('Web development')
    
    expect(page).to have_css('h1', text: 'Web development')
    expect(page).to have_content(book.title)
    expect(page).to have_content(book.price)
  end
  
  scenario 'user can see path relative to the home page (breadcrumb)' do
    visit(category_path(history))
    
    expect(page.find('.breadcrumb')).to have_link('Home')
    expect(page.find('.breadcrumb')).to have_link('Shop')
    expect(page.find('.breadcrumb')).to have_css('li.active', text: 'History')
  end
end