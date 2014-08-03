class Goal < ActiveRecord::Base
  belongs_to :user
  has_many :checkins

  validates_presence_of :name
  validates_presence_of :user_id
  validates_uniqueness_of :name, scope: :user_id

  def get_checkin_for(day)
    checkins.find_by_truncated_date(day.strftime('%m%d%Y'))
  rescue NoMethodError
    logger.error 'Argument must be a DateTime object.'
    return false
  end

  def checked_in?(day)
    get_checkin_for(day).present?
  end
end
