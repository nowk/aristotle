require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation, { only: %w[users] }

feature 'User logs in' do
  before(:each) do
    user = FactoryGirl.create(:user)
  end

  after(:each) do
    DatabaseCleaner.clean
  end

  scenario 'proper email/password takes User to dashboard' do
    visit '/login'
    fill_in 'email', with: 'john@example.com'
    fill_in 'password', with: 'password'
    click_button 'Login'
    expect(page).to have_content 'My Goals'
  end

  scenario 'invalid email/password display error message' do
    visit '/login'
    fill_in 'email', with: 'baduser@example.com'
    fill_in 'password', with: 'password'
    click_button 'Login'
    expect(page).to have_selector '.alert'
  end
end
