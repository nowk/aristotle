require 'rails_helper'

feature 'User sets cheat days' do
  before :each do
    @prechecked_days = ['Monday', 'Thursday', 'Saturday']
    @goal.update_attributes(cheat_days: @prechecked_days)
    visit edit_user_goal_path(@user.id, @goal.id)
  end

  scenario 'User should be able to view edit page without any cheat days' do
    goal = FactoryGirl.create(:goal, { id: 2, name: 'othername', cheat_days: nil })
    visit edit_user_goal_path(@user.id, goal.id)
    expect(page).not_to have_checked_field 'monday'
  end

  scenario 'User edits goal and it should show the cheat days in a list' do
    @prechecked_days.each do |day|
      expect(page).to have_content(day) 
    end

    expect(page).not_to have_content('Tuesday')
  end
end
