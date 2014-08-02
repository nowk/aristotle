FactoryGirl.define do
  factory :user do
    id '1'
    email 'john@example.com'
    password 'password'
    password_confirmation 'password'
  end
end
