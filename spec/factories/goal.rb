FactoryGirl.define do
  factory :goal do
    id '1'
    name 'Goal A'
    description 'Foo'
    user_id '1'
    cheat_days ['Monday', 'Tuesday']
  end

  factory :newgoal, class: Goal do
    name { Faker::Lorem.sentence }
  end
end
