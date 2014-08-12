FactoryGirl.define do
  factory :user do
    id '1'
    email 'john@example.com'
    password 'password'
    password_confirmation 'password'
  end

  factory :newuser, class: User do
    email { Faker::Internet.email }
    password "astrongpassword"
    password_confirmation "astrongpassword"
  end
end
