require 'rails_helper'

feature 'System remembers the date the User checked into/out of' do
  before(:each) do
    @past_date = convert_to_s(3.days.ago)
  end

  scenario 'A user checks in on a date and is redirected to the same page' do
    visit goal_with_date_path(@user.id, @goal.id, @past_date)
    click_button 'Check In'
    expect(page).to have_selector ".date[rel='#{@past_date}']"
  end

  scenario 'A user checks out on a date and is redirected to the same page' do
    checkin = FactoryGirl.create(:checkin, { truncated_date: @past_date })
    visit goal_with_date_path(@user.id, @goal.id, @past_date) 
    click_link 'Check Out'
    expect(page).to have_selector ".date[rel='#{@past_date}']"
  end
end
