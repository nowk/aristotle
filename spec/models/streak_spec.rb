require 'rails_helper'

describe Streak, 'no cheat days' do
  before :each do
    [4, 2, 1, 0].each do |n|
      FactoryGirl.create(:checkin, { truncated_date: convert_to_s(n.days.ago) })
    end
    @checkins = @goal.checkins.order('truncated_date DESC')
    @streak = Streak.new(@checkins)
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
    checkins = @goal.checkins.order 'truncated_date DESC'
    streak = Streak.new(checkins)
    expect(streak.days).to eq(5)
  end
end

describe Streak, 'with cheat days' do
  before :each do
    @dates_array = (0..6).to_a 
    @goal.update_attributes(cheat_days: ['Monday', 'Thursday', 'Saturday'])
  end
  
  it 'should not break streak for a cheat day' do
    @dates_array.delete(3)
    create_checkins(@dates_array)

    checkins = @goal.checkins.order 'truncated_date DESC'
    streak = Streak.new(checkins)
    expect(streak.days).to eq(7)
  end

  it 'should not break streak for different combination' do
    @dates_array.delete(2)
    create_checkins(@dates_array)

    checkins = @goal.checkins.order 'truncated_date DESC'
    streak = Streak.new(checkins)
    expect(streak.days).to eq(2)
  end
  
  it 'should not break streak for yet another combination' do
    @dates_array.delete(5)
    create_checkins(@dates_array)

    checkins = @goal.checkins.order 'truncated_date DESC'
    streak = Streak.new(checkins)
    expect(streak.days).to eq(5)
  end
end
