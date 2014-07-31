require 'rails_helper'

describe Goal, 'validations' do
  it 'should not create a goal with a blank name' do
    goal = FactoryGirl.build(:goal)
    goal.name = nil
    expect(goal).not_to be_valid
  end

  it 'should not create a goal with a duplicate name among users' do
    goal = FactoryGirl.build(:goal)
    goal.user_id = 1
    goal.save

    duplicate_goal = FactoryGirl.build(:goal)
    duplicate_goal.user_id = 1
    expect(duplicate_goal).not_to be_valid
  end

  it 'should allow different users to have goals of the same name' do
    goal = FactoryGirl.build(:goal)
    goal.user_id = 1
    goal.save

    different_users_goal = FactoryGirl.build(:goal)
    different_users_goal.user_id = 2
    expect(different_users_goal).to be_valid
  end
end
