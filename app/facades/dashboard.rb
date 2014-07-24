class Dashboard
  def initialize(user)
    @user = user
  end

  def goals
    @goals = @user.goals
  end

  def timezones
    @timezones ||= ActiveSupport::TimeZone.us_zones.map { |z| z.name }
  end

  private

    attr_reader :user
end
