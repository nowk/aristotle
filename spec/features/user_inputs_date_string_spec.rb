require 'rails_helper'

feature 'User inputs a date string to go to that date for a goal' do
  scenario 'entering a valid date string' do
    visit goal_with_date_path(@user.id, @goal.id, '08182008')
    expect(page).to have_selector '.date[rel="08182008"]'
  end

  scenario 'entering no date string' do
    @date = convert_to_s(DateTime.now)
    visit user_goal_path(@user.id, @goal.id)
    expect(page).to have_selector ".date[rel='#{@date}']"
  end

  scenario 'entering an invalid date string' do
    url = goal_path(@user.id, @goal.id)
    expect{visit url + '/foo'}.to raise_error ActionController::RoutingError
  end
end
