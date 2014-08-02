class Checkin < ActiveRecord::Base
  belongs_to :goal

  validates_presence_of :goal_id
  validates_presence_of :truncated_date

  validate :valid_date

  #validates_uniqueness_of :truncated_date, scope: :goal_id
 
  private
    def valid_date
      DateTime.strptime(truncated_date, '%m%d%Y') unless truncated_date.nil?
    rescue ArgumentError
      errors.add(:truncated_date, 'must be in the form mmddyyyy')
    end
end
