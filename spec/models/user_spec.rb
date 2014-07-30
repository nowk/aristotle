require 'rails_helper'

describe User, 'validations' do
  it 'should not create a user with a duplicate email' do
    user = FactoryGirl.create(:user)
    duplicate_user = User.create(email: user.email, password: user.password, password_confirmation: user.password_confirmation)
    expect(duplicate_user).not_to be_valid
  end

  it 'should not accept a blank email' do
    user = FactoryGirl.build(:user)
    user.email = ''
    expect(user).not_to be_valid
  end

  it 'should not accept a blank password' do
    user = FactoryGirl.build(:user)
    user.password = nil 
    expect(user).not_to be_valid
  end

  it 'should not accept a blank password confirmation' do
    user = FactoryGirl.build(:user)
    user.password_confirmation = nil
    expect(user).not_to be_valid
  end
end
