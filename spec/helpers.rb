module Helpers
  def convert_to_s(date)
    date.strftime('%m%d%Y')
  end

  def construct_date_array(checkins)
    checkins.map { |checkin| DateTime.strptime(checkin.truncated_date, '%m%d%Y') }.sort.reverse
  end

  def create_checkins(numbers)
    numbers.each do |n|
      FactoryGirl.create(:checkin, { truncated_date: convert_to_s(n.days.ago) })
    end
  end
end
