require 'rails_helper'

describe Goal, 'validations' do
  it 'should not create a goal with a blank name' do
    goal = FactoryGirl.build(:goal)
    goal.name = nil

    expect(goal).not_to be_valid
    expect(goal.errors.messages[:name].count).to eq(1)
    expect(goal.errors.messages[:name].first).to eq("can't be blank")
  end

  it 'should require the presence of user_id' do
    goal = FactoryGirl.build(:goal)
    goal.user_id = nil

    expect(goal).not_to be_valid
    expect(goal.errors.messages[:user_id].count).to eq(1)
    expect(goal.errors.messages[:user_id].first).to eq("can't be blank")
  end

  it 'should not create a goal with a duplicate name among users' do
    goal = FactoryGirl.build(:goal)
    goal.save

    duplicate_goal = FactoryGirl.build(:goal)

    expect(duplicate_goal).not_to be_valid
    expect(duplicate_goal.errors.messages[:name].count).to eq(1)
    expect(duplicate_goal.errors.messages[:name].first).to eq("has already been taken")
  end

  it 'should allow different users to have goals of the same name' do
    goal = FactoryGirl.build(:goal)
    goal.save

    different_users_goal = FactoryGirl.build(:goal)
    different_users_goal.user_id = 2
    expect(different_users_goal).to be_valid
  end
end
