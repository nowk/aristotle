module Helpers
  def convert_to_s(date)
    date.strftime('%m%d%Y')
  end

  def construct_date_array(checkins)
    date_array = []
    checkins.each do |checkin|
      date_array << DateTime.strptime(checkin.truncated_date, '%m%d%Y')
    end
    date_array.sort.reverse
  end
end
