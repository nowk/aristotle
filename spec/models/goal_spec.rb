require 'rails_helper'

describe Goal, 'validations' do
  it 'should create a goal with a valid name' do
    goal = FactoryGirl.build(:goal) 
    expect(goal).to be_valid
  end

  it 'should not create a goal with a blank name' do
    goal = FactoryGirl.build(:goal)
    goal.name = nil
    expect(goal).not_to be_valid
  end
end
