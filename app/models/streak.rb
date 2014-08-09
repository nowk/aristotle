class Streak
  attr_reader :dates

  def initialize(checkins)
    @checkins = checkins
    @streak_count = 1
  end

  def days
    @checkins.each_cons(2) do |a, b|
      if one_day_apart?(a, b) 
        @streak_count += 1
      else
        factor_in_cheat_days(a, b) ? next : break
      end
    end
    @streak_count 
  end

  private
    def to_d(checkin)
      Date.strptime(checkin.truncated_date, '%m%d%Y')
    end

    def one_day_apart?(a, b)
      (to_d(a) - to_d(b)).to_i === 1 
    end

    def is_cheat_day?(day, goal)
      goal.cheat_days.include?(Date::DAYNAMES[day.wday])
    end

    def n_days_apart(a, b)
      (to_d(a) - to_d(b)).to_i
    end

    def factor_in_cheat_days(a, b)
      days_apart = n_days_apart(a, b)
      (1..(days_apart - 1)).each do |n|
        examined_day = to_d(a) - n.days
        if is_cheat_day?(examined_day, a.goal)
          @streak_count += 1
        else
          return false
        end
      end
      @streak_count += 1
    end
end
