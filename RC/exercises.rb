loop do
  number = rand(100)
  puts number
  break if (0..10).cover?(number)
end
