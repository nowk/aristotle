require 'rails_helper'

describe Checkin, 'validations' do
  let!(:user) { FactoryGirl.create :newuser }
  let!(:goal) { FactoryGirl.create :newgoal, user: user }

  it 'should not create a checkin with a blank goal id' do
    checkin = Checkin.new

    expect(checkin).not_to be_valid
    expect(checkin.errors.messages[:goal_id]).to include("can't be blank")
  end

  it "should not create a checkin if a the goal does not exist" do
    checkin = Checkin.new goal_id: 123

    expect(checkin).not_to be_valid
    expect(checkin.errors.messages[:goal]).to include("can't be blank")
  end

  it 'should not create a checkin with a blank truncated_date' do
    checkin = Checkin.new goal: goal
    checkin.truncated_date = nil

    expect(checkin).not_to be_valid
    expect(checkin.errors.messages[:truncated_date]).to include("can't be blank")
  end

  it 'should not allow a duplicate truncated date' do
    checkin = FactoryGirl.create :checkin, goal: goal
    dup_checkin = Checkin.new goal: goal, truncated_date: checkin.truncated_date

    expect(dup_checkin).not_to be_valid
    expect(dup_checkin.errors.messages[:truncated_date]).to include('has already been taken')
  end

  it 'should allow duplicate truncated dates if the goal id is different' do
    another_goal = FactoryGirl.create :newgoal, user: user
    FactoryGirl.create :newcheckin, goal: goal

    different_users_checkin = FactoryGirl.build(:checkin, goal: another_goal)

    expect(different_users_checkin).to be_valid
  end
  
  it 'should not create a checkin with a malformed truncated_date string' do
    [
      'aaaaaa', 
      '08-18-1988', 
      '08-18-88', 
      '1988-08-18', 
      '88-08-18', 
      '19880818', 
      '18081988', 
      '180888'
    ].each do |date|
      checkin = FactoryGirl.build :newcheckin, goal: goal
      checkin.truncated_date = date

      expect(checkin).not_to be_valid
      expect(checkin.errors.messages[:truncated_date]).to include('must be in the form mmddyyyy')
    end
  end
end
