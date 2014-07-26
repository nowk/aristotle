class Goal < ActiveRecord::Base
  belongs_to :user
  has_many :checkins

  def get_checkin_for(day)
    checkins.where(truncated_date: day.strftime('%Y-%m-%d'))
  end

  def checked_in?(day)
    get_checkin_for(day).any?
  end
end
