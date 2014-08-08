class Goal < ActiveRecord::Base
  belongs_to :user
  has_many :checkins

  validates_presence_of :name
  validates_presence_of :user_id
  validates_uniqueness_of :name, scope: :user_id

  serialize :cheat_days, Array

  def get_checkin_for(day)
    checkins.find_by_truncated_date(day.strftime('%m%d%Y'))
  rescue NoMethodError
    logger.error 'Argument must be a DateTime object.'
    return false
  end

  def checked_in?(day)
    get_checkin_for(day).present?
  end

  def total_checkins
    checkins.where(goal_id: self.id).count
  end

  def current_streak
    Streak.new(checkins.select('truncated_date')).days
  end
end
