puts "-------------------Welcome to Mortgage Calculator------------------"
loop do
	def strip(n)
		#This method strips trailing zeros
		n.to_s.sub(/\.?0+$/, '')
	end

	def output(message, type = "f")
		num = nil
		loop do
			puts "=> " + message
			num = gets.chomp
			if num.empty?
				puts "You must type something!"
				next
			elsif type == "f" && strip(num) == num.to_f.to_s || num == num.to_i.to_s
				num = num.to_f
				break
			elsif type == "i" && num == num.to_i.to_s
				num = num.to_i
				break
			else
				puts "That was not a valid input or you put an unnecessary zero in the decimal place."
				next
			end
		end
		num
	end

	apr = <<APR
What is the Annual Percentage Rate(APR)?
If it is 5% just type 5,
   for 2.5% just type 2.5.
APR

	p = output("How much is the loan for?", "f")
	j = output(apr, "f") / 100 / 12
	n = output("How long is the loan duration in years?", "i") * 12
	m = (p * (j / (1 - (1 + j) ** (-n))))
	m = "$" + "#{(m).round(2)}"

	puts "Your loan duration in months is #{n.to_i}."
	puts "Your monthly payment is #{m}."
	puts "=> Would you like to make another calculation?"
	answer = gets.chomp.downcase
	if answer != "no"
		next
	else
		break
	end
end
puts "-----Thank you for using Mortgage Calculator, have a nice rest of your day!-----"
