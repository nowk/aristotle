require 'rails_helper'

describe Goal, 'validations', skip_before: true do
  it 'should not create a goal with a blank name' do
    goal = FactoryGirl.build :goal
    goal.name = nil

    expect(goal).not_to be_valid
    expect(goal.errors.messages[:name]).to include("can't be blank")
  end

  it 'should require the presence of user_id' do
    goal = FactoryGirl.build :goal
    goal.user_id = nil

    expect(goal).not_to be_valid
    expect(goal.errors.messages[:user_id]).to include("can't be blank")
  end

  it 'should not create a goal with a duplicate name within a single user' do
    goal = FactoryGirl.build :goal
    goal.save

    duplicate_goal = FactoryGirl.build :goal

    expect(duplicate_goal).not_to be_valid
    expect(duplicate_goal.errors.messages[:name]).to include("has already been taken")
  end

  it 'should allow different users to have goals of the same name' do
    goal = FactoryGirl.build :goal
    goal.save

    different_users_goal = FactoryGirl.build :goal
    different_users_goal.user_id = 2
    expect(different_users_goal).to be_valid
  end
end

describe Goal, '#get_checkin_for(day)', skip_before: true do
  before(:each) do
    @goal = FactoryGirl.create :goal
    @checkin = FactoryGirl.create :checkin
  end

  it 'should return a checkin record' do
    checkin_record = @goal.get_checkin_for(DateTime.now)
    expect(checkin_record).to be_an_instance_of(Checkin)
  end

  it 'should return a checkin record if a user has checked in for that day' do
    checkin_record = @goal.get_checkin_for(DateTime.now)
    expect(checkin_record).to be
  end

  it 'should return nil if a user has not checked in for that day' do
    checkin_record = @goal.get_checkin_for(1.day.ago)
    expect(checkin_record).to be_nil
  end
end

describe Goal, '#checked_in?(day)', skip_before: true do
  before(:each) do
    @goal = FactoryGirl.create :goal
  end

  it 'should return true for an existing checkin' do
    FactoryGirl.create :checkin
    result = @goal.checked_in? DateTime.now
    expect(result).to be true
  end

  it 'should return false for a date with no checkin' do
    result = @goal.checked_in? DateTime.now
    expect(result).to be false
  end

  it 'should return false for non-date objects' do
    result = @goal.checked_in? 'asdfasdf'
    expect(result).to be false
  end
end

describe Goal, '#total_checkins', skip_before: true do
  before :each do
    @goal = FactoryGirl.create :goal
    FactoryGirl.create :checkin
    FactoryGirl.create :checkin, { truncated_date: convert_to_s(1.day.ago) }
    FactoryGirl.create :checkin, { truncated_date: convert_to_s(2.days.ago) }
  end

  it 'should return a count for only this goal' do
    result = @goal.total_checkins 
    expect(result).to eq(3)
  end

  it 'should not count checkins for a different goal_id' do
    FactoryGirl.create :checkin, { goal_id: 2 }
    result = @goal.total_checkins
    expect(result).to eq(3)
  end
end

describe Goal, '#current_streak' do 
  before :each do
    [4, 2, 1, 0].each do |n|
      FactoryGirl.create(:checkin, { truncated_date: convert_to_s(n.days.ago) })
    end
  end

  it 'should return the count of consecutive days checked in leading up to today' do
    expect(@goal.current_streak).to eq(3)
  end
end
