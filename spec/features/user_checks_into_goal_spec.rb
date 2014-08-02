require 'rails_helper'

feature 'User can check into/out of a goal on the goal show page' do
  before(:each) do
    @user = FactoryGirl.create :user
    @goal = FactoryGirl.create :goal
    page.set_rack_session(user_id: @user.id)
  end

  scenario 'User hasn\'t checked into a goal for a specific date' do
    visit user_goal_path @user, @goal
    click_button 'Check In'
    expect(page).to have_selector('.notice')
    expect(page).to have_selector('button[rel="checkout"]')
  end

  scenario 'User has checked into a goal for a specific date' do
    checkin = FactoryGirl.create :checkin 
    visit user_goal_path @user, @goal
    click_button 'Check Out' 
    expect(page).to have_selector('.notice')
    expect(page).to have_selector('button[rel="checkin"]')
  end
end
