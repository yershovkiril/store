require_relative 'features_helper'

feature 'Best sellers carousel' do
  scenario 'presents on main page' do
    visit(root_path)
    
    expect(page).to have_css '.bxslider'
  end
end