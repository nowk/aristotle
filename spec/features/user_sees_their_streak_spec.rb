require 'rails_helper'

feature 'User sees their streak' do
  before :each do
    [4, 2, 1, 0].each do |n|
      FactoryGirl.create(:checkin, { truncated_date: convert_to_s(n.days.ago) })
    end
  end

  scenario 'User goes to goal index and can see their current streak' do
    visit user_goals_path @user.id
    el = page.find("*[data-goal-id='#{@goal.id}']").find('.current-streak')  
    expect(el).to have_text(3)
  end

  scenario 'User links up a streak by checking into a past date' do
    visit goal_with_date_path(@user.id, @goal.id, convert_to_s(3.days.ago))
    click_button 'Check In'
    visit user_goals_path @user.id
    el = page.find("*[data-goal-id='#{@goal.id}']").find('.current-streak')
    expect(el).to have_text(5)
  end
end
