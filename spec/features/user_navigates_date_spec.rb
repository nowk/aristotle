require 'rails_helper'

feature 'User can navigate date on show page' do
  before :each do
    @user = FactoryGirl.create :user
    @goal = FactoryGirl.create :goal
    page.set_rack_session(user_id: @user.id)
  end

  scenario 'User goes to show page and can navigate to next day' do
    tomorrow = DateTime.now.tomorrow.strftime('%m%d%Y')
    visit user_goal_path(@user.id, @goal.id)
    click_link 'Next Day'
    expect(page).to have_selector ".date[rel='#{tomorrow}']"
  end

  scenario 'User goes to show page and can navigate to previous day' do
    yesterday = DateTime.now.yesterday.strftime('%m%d%Y')
    visit user_goal_path(@user.id, @goal.id)
    click_link 'Previous Day'
    expect(page).to have_selector ".date[rel='#{yesterday}']"
  end
end
