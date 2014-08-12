class Goal < ActiveRecord::Base
  belongs_to :user
  has_many :checkins
  has_many :prizes

  validates_presence_of :name
  validates_presence_of :user_id
  validates_uniqueness_of :name, scope: :user_id

  serialize :cheat_days, JSON
  before_create :convert_cheat_days

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
    Streak.new(checkins.order('truncated_date DESC')).days
  end

  def convert_cheat_days
    self.cheat_days ||= [] if self.cheat_days.blank?
  end
end
