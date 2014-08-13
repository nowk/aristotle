FactoryGirl.define do
  factory :newuser, class: User do
    email { Faker::Internet.email }
    password "astrongpassword"
    password_confirmation "astrongpassword"
  end
end
