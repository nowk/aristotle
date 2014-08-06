require 'rails_helper'

feature 'User goes into goal index and sees total checkins for a goal' do
  before :each do
    [0, 1, 2].each do |n|
      FactoryGirl.create :checkin, { truncated_date: convert_to_s(n.days.ago) }
    end
  end

  scenario 'User has already checked in several times' do
    visit user_goals_path(@user.id)
    el = page.find("tr[data-goal-id='#{@goal.id}']").find('.total-checkins')
    expect(el).to have_text(3)
  end
end
