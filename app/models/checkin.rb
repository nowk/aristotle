class Checkin < ActiveRecord::Base
  belongs_to :goal

  validates_uniqueness_of :truncated_date, scope: :goal_id
end
