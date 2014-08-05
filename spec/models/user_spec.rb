require 'rails_helper'

describe User, 'validations', skip_before: true do
  before(:each) do
    @user = FactoryGirl.create(:user)
  end

  it 'should not create a user with a duplicate email' do
    duplicate_user = User.create(email: @user.email, password: @user.password, password_confirmation: @user.password_confirmation)
    expect(duplicate_user).not_to be_valid
  end

  it 'should not accept a blank email' do
    @user.email = ''
    @user.valid?
    expect(@user.errors.messages).to have_key(:email)
  end

  it 'should not accept a blank password' do
    @user.password = nil 
    @user.valid?
    expect(@user.errors.messages).to have_key(:password) 
  end

  it 'should not accept a blank password confirmation' do
    @user.password_confirmation = nil
    @user.valid?
    expect(@user.errors.messages).to have_key(:password_confirmation) 
  end

  it 'should not accept mismatching password and password confirmation fields' do
    @user.password = 'foo'
    @user.password_confirmation = 'bar'
    @user.valid?
    expect(@user.errors.messages).to have_key(:password_confirmation)
  end
end
