loop do
puts "What is your float?"
float = gets.chomp

puts "translating to float...#{float.to_f}"
puts "translating back to string... is #{float} equal to #{float.to_f.round(2).to_s}?"
end
