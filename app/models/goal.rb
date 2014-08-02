class Goal < ActiveRecord::Base
  belongs_to :user
  has_many :checkins

  validates_presence_of :name
  validates_presence_of :user_id
  validates_uniqueness_of :name, scope: :user_id

  def get_checkin_for(day)
    checkins.where(truncated_date: day.strftime('%m%d%Y'))
  end

  def checked_in?(day)
    get_checkin_for(day).any?
  end
end
