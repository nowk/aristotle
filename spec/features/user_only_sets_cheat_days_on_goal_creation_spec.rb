require 'rails_helper'

feature 'User can only set cheat day when creating goal' do
  scenario 'User can set cheat days at creation of goal' do
    visit new_user_goal_path @user.id
    fill_in 'goal[name]', with: 'Barbaz'
    page.find(:css, '#monday').set(true)
    page.find(:css, '#tuesday').set(true)
    click_button 'Create Goal'
    expect(page).to have_selector('.notice')
    visit edit_user_goal_path(@user.id, Goal.last.id)
    expect(page).to have_content('Monday')
    expect(page).to have_content('Tuesday')
  end

  scenario 'User cannot edit cheat days after goal has been created' do
    visit edit_user_goal_path(@user.id, @goal.id)
    
    Date::DAYNAMES.each do |day|
      expect(page).not_to have_unchecked_field(day.downcase)
    end
  end
end
