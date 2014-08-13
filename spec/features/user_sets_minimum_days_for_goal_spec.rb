require 'rails_helper'

feature 'User is able to set minimum days for completeness for goal' do
  scenario 'When user creates goal, she can set a minimum number of days on a goal' do
    visit new_user_goal_path @user.id 
    fill_in 'goal[name]', with: 'Some Goal'
    fill_in 'goal[minimum_days]', with: '21'
    click_button 'save-goal'
    expect(page).to have_selector '.notice'
  end
end
