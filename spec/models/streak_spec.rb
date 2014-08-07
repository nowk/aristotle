require 'rails_helper'

describe Streak do
  before(:each) do
    [4, 2, 1, 0].each do |n|
      FactoryGirl.create(:checkin, { truncated_date: convert_to_s(n.days.ago) })
    end
    @checkins = @goal.checkins.select('truncated_date')
    @streak = Streak.new(@checkins)
  end

  it 'converts an array of checkin models to an array of truncated_date strings' do
    correct_date_array = construct_date_array(@checkins)
    expect(@streak.dates).to eq(correct_date_array)
  end

  it 'calculates the amount of days in your current streak' do
    expect(@streak.days).to eq(3)
  end
  
  it 'should count todays checkin' do
    goal = FactoryGirl.create(:goal, { id: '2', name: 'Bar' })
    FactoryGirl.create(:checkin, { goal_id: '2' })

    streak = Streak.new(goal.checkins.select('truncated_date'))
    expect(streak.days).to eq(1)
  end

  it 'should link up check in days properly' do
    FactoryGirl.create(:checkin, { truncated_date: convert_to_s(3.days.ago) })
    checkins = @goal.checkins.select('truncated_date')
    streak = Streak.new(checkins)
    expect(streak.days).to eq(5)
  end
end
