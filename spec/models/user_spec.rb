require 'rails_helper'

describe User, 'validations' do
  before(:each) do
    @user = FactoryGirl.create(:user)
  end

  it 'should not create a user with a duplicate email' do
    duplicate_user = User.create(email: @user.email, password: @user.password, password_confirmation: @user.password_confirmation)
    expect(duplicate_user).not_to be_valid
  end

  it 'should not accept a blank email' do
    @user.email = ''
    expect(@user).not_to be_valid
  end

  it 'should not accept a blank password' do
    @user.password = nil 
    expect(@user).not_to be_valid
  end

  it 'should not accept a blank password confirmation' do
    @user.password_confirmation = nil
    expect(@user).not_to be_valid
  end

  it 'should not accept mismatching password and password confirmation fields' do
    @user.password = 'foo'
    @user.password_confirmation = 'bar'
    expect(@user).not_to be_valid
  end
end
