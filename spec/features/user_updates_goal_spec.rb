require 'rails_helper'

feature 'User updates goal' do
  before :each do
    visit edit_user_goal_path(@user.id, @goal.id)
  end

  scenario 'User updates goal with valid info' do
    fill_in 'goal[name]', with: 'BarBaz'
    fill_in 'goal[description]', with: 'This is just sample description.'
    click_button 'save-goal'
    expect(page).to have_selector '.notice'
  end

  scenario 'User updates goal with invalid info' do
    fill_in 'goal[name]', with: ''
    click_button 'save-goal'
    expect(page).to have_selector '.alert'
  end
end
