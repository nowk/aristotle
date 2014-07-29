require 'rails_helper'
require 'database_cleaner'

describe User, 'email uniqueness' do
  it 'should not create a user with a duplicate email' do
    user = FactoryGirl.create(:user)
    duplicate_user = User.create(email: user.email, password: user.password, password_confirmation: user.password_confirmation)
    expect(duplicate_user).not_to be_valid
  end
end
