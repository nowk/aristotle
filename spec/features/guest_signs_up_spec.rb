require 'rails_helper'
require 'database_cleaner'

DatabaseCleaner.strategy = :truncation, { only: %w[users] }

feature 'Guest signs up', skip_before: true do
  scenario 'valid email, password & password confirmation brings User to dashboard with confirmation dialog' do
    visit '/signup'
    fill_in 'user_email', with: 'johndoe@example.com'
    fill_in 'user_password', with: 'password'
    fill_in 'user_password_confirmation', with: 'password'
    click_button 'Sign Up'
    expect(page).to have_content 'My Goals'
    expect(page).to have_selector '.notice'
  end

  scenario 'providing invalid information displays error notice' do
    visit '/signup'
    fill_in 'user_email', with: 'johndoe'
    fill_in 'user_password', with: ''
    fill_in 'user_password_confirmation', with: 'password'
    click_button 'Sign Up'
    expect(page).to have_selector '.alert'
  end
end
