module GoalsHelper
  def local_date(user)
    ActiveSupport::TimeZone.new(user.time_zone).today.strftime '%m%d%Y'
  end

  def day_after(date)
    "#{user_goal_path(current_user.id, @goal_summary.goal.id)}/#{date.tomorrow.strftime('%m%d%Y')}"
  end

  def day_before(date)
    "#{user_goal_path(current_user.id, @goal_summary.goal.id)}/#{date.yesterday.strftime('%m%d%Y')}"
  end

  def is_today?
    DateTime.now === @goal_summary.date
  end

  def check_cheat_day(day)
    day if @goal.cheat_days.include? day
  end
end
