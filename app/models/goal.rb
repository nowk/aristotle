class Goal < ActiveRecord::Base
  belongs_to :user
  has_many :checkins

  validates_presence_of :name

  def get_checkin_for(day)
    checkins.where(truncated_date: day.strftime('%Y-%m-%d'))
  end

  def checked_in?(day)
    get_checkin_for(day).any?
  end
end
