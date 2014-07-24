module GoalsHelper
  def local_date(user)
    ActiveSupport::TimeZone.new(user.time_zone).today.strftime '%m%d%Y'
  end
end
