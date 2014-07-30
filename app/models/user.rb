class User < ActiveRecord::Base
  has_secure_password
  has_many :goals

  validates_uniqueness_of :email
  validates_presence_of :email, :password, :password_confirmation
end
