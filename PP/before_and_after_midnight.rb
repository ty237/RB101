def hours_and_minutes(time)
  time.split(":").map(&:to_i)
end

def after_midnight(time)
  hours, minutes = hours_and_minutes(time)
  (1440 + (hours * 60) + minutes) % 1440
end

def before_midnight(time)
  hours, minutes = hours_and_minutes(time)
  (1440 - ((hours * 60) + minutes)) % 1440
end

puts after_midnight('00:00') == 0
puts before_midnight('00:00') == 0
puts after_midnight('12:34') == 754
puts before_midnight('12:34') == 686
puts after_midnight('24:00') == 0
puts before_midnight('24:00') == 0
