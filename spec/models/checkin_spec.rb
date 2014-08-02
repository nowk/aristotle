require 'rails_helper'

describe Checkin, 'validations' do
  it 'should not create a checkin with a blank goal id' do
    checkin = FactoryGirl.build :checkin
    checkin.goal_id = nil
    
    expect(checkin).not_to be_valid
    expect(checkin.errors.messages[:goal_id].count).to eq(1)
    expect(checkin.errors.messages[:goal_id].first).to eq("can't be blank")
  end

  it 'should not create a checkin with a blank truncated_date' do
    checkin = FactoryGirl.build :checkin
    checkin.truncated_date = nil

    expect(checkin).not_to be_valid
    expect(checkin.errors.messages[:truncated_date].count).to eq(1)
    expect(checkin.errors.messages[:truncated_date].first).to eq("can't be blank")
  end
  
  it 'should not create a checkin with a malformed truncated_date string' do
    bad_date_strings = ['aaaaaa', '08-18-1988', '08-18-88', '1988-08-18', '88-08-18', '19880818', '18081988', '180888']
    bad_date_strings.each do |date|
      checkin = FactoryGirl.build :checkin
      checkin.truncated_date = date

      expect(checkin).not_to be_valid
      expect(checkin.errors.messages[:truncated_date]).to include('must be in the form mmddyyyy')
    end
  end

end
