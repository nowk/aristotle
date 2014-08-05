require 'rails_helper'

feature 'User logs in', skip_before: true do
  before(:each) do
    user = FactoryGirl.create(:user)
    visit login_path
  end

  scenario 'valid email/password takes User to dashboard' do
    fill_in 'email', with: 'john@example.com'
    fill_in 'password', with: 'password'
    click_button 'Login'
    expect(page).to have_selector '.dashboard'
  end

  scenario 'invalid email/password display error message' do
    fill_in 'email', with: 'baduser@example.com'
    fill_in 'password', with: 'password'
    click_button 'Login'
    expect(page).to have_selector '.alert'
  end
end
