def format(num)
  return "0#{num}" if num < 10
  num
end

def what_day(days)
  case days % 7
  when 0
    "Sunday"
  when 1
    "Monday"
  when 2
    "Tuesday"
  when 3
    "Wedneday"
  when 4
    "Thursday"
  when 5
    "Friday"
  when 6
    "Saturday"
  end
end

def time_of_day(minutes)
  days, minutes = minutes.divmod(1440)
  hours, minutes = minutes.divmod(60)
  "#{what_day(days)} #{format(hours)}:#{format(minutes)}"
end

puts time_of_day(-4231)
