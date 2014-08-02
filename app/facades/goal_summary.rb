class GoalSummary
  attr_reader :goal, :description, :name, :date, :checkin

  def initialize(goal, date_string)
    @goal = goal
    @checkin = @goal.checkins.new
    @description = @goal.description
    @name = @goal.name
    @date = DateTime.strptime(date_string, '%m%d%Y')
  end

  def checkins
    @checkins ||= @goal.checkins
  end

  def todays_checkin
    @todays_checkin ||= @goal.get_checkin_for(@date).first
  end

  def todays_checkin_id
    @todays_checkin_id ||= @todays_checkin.id
  end

  def goal_id
    @goal_id ||= @goal.id
  end

end
