require 'rails_helper'

feature 'User creates goal' do
  before(:each) do
    user = FactoryGirl.create(:user)
    page.set_rack_session(user_id: user.id)
    visit new_user_goal_path(user.id)
  end

  scenario 'clicking submit with a valid name' do
    fill_in 'goal[name]', with: 'Foo Goal'
    click_button 'Create Goal'
    expect(page).to have_selector('.notice')
    expect(page).to have_selector('.goal-index')
    expect(page).to have_content('Foo Goal')
  end

  scenario 'clicking submit with an invalid name will display an error' do
    click_button 'Create Goal'
    expect(page).to have_selector('.alert')
  end
end
