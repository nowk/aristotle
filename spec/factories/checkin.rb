FactoryGirl.define do
  factory :checkin do
    goal_id '1' 
    truncated_date { DateTime.now.strftime('%m%d%Y') }
  end

  factory :newcheckin, class: Checkin do
    truncated_date { DateTime.now.strftime('%m%d%Y') }
  end
end
