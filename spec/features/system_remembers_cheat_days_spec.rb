require 'rails_helper'

feature 'System remembers cheat days' do
  before :all do
    @dates_array = (0..6).to_a
    @dates_array.delete(3)
  end

  before :each do
    @dates_array.each do |n|
      FactoryGirl.create(:checkin, { truncated_date: convert_to_s(n.days.ago) })
      @goal.update_attributes(cheat_days: ['Monday', 'Thursday', 'Saturday'])
    end
  end

  scenario 'User sets cheat days and the system takes those cheats days into account when calculating a streak' do
    visit user_goals_path @user.id
    el = page.find("*[data-goal-id='#{@goal.id}']").find('.current-streak')
    expect(el).to have_text(7)
  end
end
