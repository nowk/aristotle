require 'rails_helper'

describe Prize, 'validations' do
  it 'should not accept a prize with a blank name' do
    prize = FactoryGirl.build(:prize, { name: '' })

    expect(prize).not_to be_valid
    expect(prize.errors.messages[:name]).to include 'can\'t be blank'
  end
end
