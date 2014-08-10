FactoryGirl.define do
  factory :goal do
    id '1'
    name 'Goal A'
    description 'Foo'
    user_id '1'
    cheat_days ['Monday', 'Tuesday']
  end
end
