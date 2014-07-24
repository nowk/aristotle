class Goal < ActiveRecord::Base
  belongs_to :user
  has_many :checkins

  def checked_in?(today)
    checkins.where(created_at: today.beginning_of_day..today.end_of_day).any?
  end
end
