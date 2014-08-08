require 'rails_helper'

feature 'User sets cheat days' do
  before :each do
    @prechecked_days = ['Monday', 'Thursday', 'Saturday']
    visit edit_user_goal_path(@user.id, @goal.id)
  end

  scenario 'User edits a goal and sees checkboxes for each of the days of the week' do
    expect(page).to have_selector '.cheat-days'
    expect(page.all('.day-of-week').count).to eq(7)
  end

  scenario 'User submits changes and sees a success dialog' do
    page.check 'monday'
    click_button 'Save Goal'
    expect(page).to have_selector '.notice'
  end

  scenario 'User edits goal and it should show the correct checkboxes marked for already selected cheat days' do
    @prechecked_days.each do |day|
      expect(page).to have_checked_field(day.downcase)
    end
  end
end
