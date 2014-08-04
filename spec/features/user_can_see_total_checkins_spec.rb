require 'rails_helper'

feature 'User goes into goal index and sees total checkins for a goal' do
  before :each do
    @user = FactoryGirl.create :user
    @goal = FactoryGirl.create :goal
    FactoryGirl.create :checkin, { truncated_date: convert_to_s(DateTime.now) }
    FactoryGirl.create :checkin, { truncated_date: convert_to_s(1.day.ago) }
    FactoryGirl.create :checkin, { truncated_date: convert_to_s(2.days.ago) }
    page.set_rack_session(user_id: @user.id)
  end

  scenario 'User checks in several times' do
    visit user_goals_path(@user.id)
    el = page.find("tr[data-goal-id='#{@goal.id}']").find('.total-checkins')
    expect(el).to have_text(3)
  end
end
