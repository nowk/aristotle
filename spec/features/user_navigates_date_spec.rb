require 'rails_helper'

feature 'User can navigate date on show page' do
  before :each do
    @user = FactoryGirl.create :user
    @goal = FactoryGirl.create :goal
    page.set_rack_session(user_id: @user.id)
  end

  scenario 'User goes to show page and can navigate to next day if on a past date' do
    today = convert_to_s(DateTime.now)
    visit goal_with_date_path(@user.id, @goal.id, convert_to_s(DateTime.yesterday))
    click_link 'Next Day'
    expect(page).to have_selector ".date[rel='#{today}']"
  end

  scenario 'User goes to show page and can navigate to previous day' do
    yesterday = convert_to_s(DateTime.yesterday)
    visit user_goal_path(@user.id, @goal.id)
    click_link 'Previous Day'
    expect(page).to have_selector ".date[rel='#{yesterday}']"
  end

  scenario 'User goes to show page and cannot see a next day link if on todays date' do
    visit user_goal_path(@user.id, @goal.id)
    expect(page).not_to have_link 'Next Day'
  end
end
