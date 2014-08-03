require 'rails_helper'

feature 'System remembers the date the User checked into/out of' do
  before(:each) do
    @user = FactoryGirl.create :user
    @goal = FactoryGirl.create :goal
    page.set_rack_session(user_id: @user.id)
    @past_date = 3.days.ago.strftime('%m%d%Y')
  end

  scenario 'A user checks in on a date and is redirected to the same page' do
    visit goal_with_date_path(@user.id, @goal.id, @past_date)
    click_button 'Check In'
    expect(page).to have_selector ".date[rel='#{@past_date}']"
  end

  scenario 'A user checks out on a date and is redirected to the same page' do
    checkin = FactoryGirl.build :checkin
    checkin.truncated_date = @past_date
    checkin.save
    visit goal_with_date_path(@user.id, @goal.id, @past_date) 
    click_link 'Check Out'
    expect(page).to have_selector ".date[rel='#{@past_date}']"
  end
end
