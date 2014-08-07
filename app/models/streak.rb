class Streak
  attr_reader :dates

  def initialize(dates)
    @dates = convert_to_d(dates)
  end

  def days
    i = 1
    @dates.each_cons(2) do |a, b|
      if (a - b).to_i === 1
        i += 1
      else
        break
      end
    end
    i
  end

  private
    def convert_to_d(checkins)
      checkins.map { |checkin| DateTime.strptime(checkin.truncated_date, '%m%d%Y') }.sort.reverse
    end

end
