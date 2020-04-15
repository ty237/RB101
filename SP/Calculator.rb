
num1 = nil
num2 = nil
operation = nil

puts "I will ask for two numbers and an operation. I will then conduct that operation using those two numbers!"
def ask(type)
  puts "Please type in a #{type}!"
  new = gets.chomp
  return new
end

  operation = ask("operation which can be '+', '-', '*', '/' ")
  num1 = ask("integer")
  num2 = ask("nother integer")

output = case operation

	         when "+"
		         sum = num1.to_i + num2.to_i
		         sum
	         when "-"
							sum2 = num1.to_i - num2.to_i
							sum2
	         when "*"
							product = num1.to_i * num2.to_i
							product
	         when "/"
							product2 = num1.to_i / num2.to_i
							product2
         end
puts "#{num1} #{operation} #{num2} is equal to #{output}!"
