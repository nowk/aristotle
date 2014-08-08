module Helpers
  def convert_to_s(date)
    date.strftime('%m%d%Y')
  end

  def construct_date_array(checkins)
    checkins.map { |checkin| DateTime.strptime(checkin.truncated_date, '%m%d%Y') }.sort.reverse
  end
end
