require 'rails_helper'

describe Goal, 'validations' do
  it 'should not create a goal with a blank name' do
    goal = FactoryGirl.build :goal
    goal.name = nil

    expect(goal).not_to be_valid
    expect(goal.errors.messages[:name].count).to eq(1)
    expect(goal.errors.messages[:name].first).to eq("can't be blank")
  end

  it 'should require the presence of user_id' do
    goal = FactoryGirl.build :goal
    goal.user_id = nil

    expect(goal).not_to be_valid
    expect(goal.errors.messages[:user_id].count).to eq(1)
    expect(goal.errors.messages[:user_id].first).to eq("can't be blank")
  end

  it 'should not create a goal with a duplicate name within a single user' do
    goal = FactoryGirl.build :goal
    goal.save

    duplicate_goal = FactoryGirl.build :goal

    expect(duplicate_goal).not_to be_valid
    expect(duplicate_goal.errors.messages[:name].count).to eq(1)
    expect(duplicate_goal.errors.messages[:name].first).to eq("has already been taken")
  end

  it 'should allow different users to have goals of the same name' do
    goal = FactoryGirl.build :goal
    goal.save

    different_users_goal = FactoryGirl.build :goal
    different_users_goal.user_id = 2
    expect(different_users_goal).to be_valid
  end
end

describe Goal, '#get_checkin_for(day)' do
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
