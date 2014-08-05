require 'rails_helper'

feature 'User should not be able to go into the future' do
  before(:each) do
    @user = FactoryGirl.create :user
    @goal = FactoryGirl.create :goal
    page.set_rack_session(user_id: @user.id)
  end

  scenario 'User navigates to a date that is beyond today and gets redirected to today' do
    visit goal_with_date_path(@user.id, @goal.id, convert_to_s(DateTime.tomorrow)) 
    expect(page).to have_selector(".date[rel='#{convert_to_s(DateTime.now)}']")
  end
end
