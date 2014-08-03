require 'rails_helper'

feature 'User deletes a goal' do
  before :each do
    @user = FactoryGirl.create :user
    @goal = FactoryGirl.create :goal
    page.set_rack_session(user_id: @user.id)
  end

  scenario 'User navigates to goal index and deletes a goal' do
    visit user_goals_path(@user.id)
    click_link 'Destroy', { href: user_goal_path(@user.id, @goal.id) }
    expect(page).to have_selector '.notice'
    expect(page).not_to have_content @goal.name
  end
end
