class Dashboard
  def initialize(user)
    @user = user
  end

  def goals
    @goals = @user.goals
  end

  private

    attr_reader :user
end
