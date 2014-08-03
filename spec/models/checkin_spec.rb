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

  it 'should not allow a duplicate truncated date' do
    checkin = FactoryGirl.create :checkin
    dup_checkin = FactoryGirl.build :checkin

    expect(dup_checkin).not_to be_valid
    expect(dup_checkin.errors.messages[:truncated_date].count).to eq(1)
    expect(dup_checkin.errors.messages[:truncated_date].first).to eq('has already been taken')
  end

  it 'should allow duplicate truncated dates if the goal id is different' do
    checkin = FactoryGirl.create :checkin
    different_users_checkin = FactoryGirl.build(:checkin)
    different_users_checkin.goal_id = 2

    expect(different_users_checkin).to be_valid
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
