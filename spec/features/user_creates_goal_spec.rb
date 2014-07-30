require 'rails_helper'

feature 'User creates goal' do
  before(:each) do
    user = FactoryGirl.create(:user)
    visit login_path
    fill_in 'email', with: user.email
    fill_in 'password', with: 'password'
    click_button 'Login'
    visit new_user_goal_path(user.id)
  end

  scenario 'clicking submit with a valid name' do
    fill_in 'goal[name]', with: 'Foo Goal'
    click_button 'Create Goal'
    expect(page).to have_selector('.notice')
  end

end
