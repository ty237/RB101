require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

loop do

	def ask(type)
		loop do
			puts MESSAGES['ask_1'] + type
			new = gets.chomp
			if new.start_with? "+", "-", "*", "/"
				return new
			elsif new == new.to_i.to_s || new == new.to_f.to_s
				return new
			else
				puts MESSAGES['invalid_number']
				next
			end
		end
	end

	num2 = nil
	message = nil
	puts MESSAGES['welcome']
	puts MESSAGES['explanation']
	operation = ask MESSAGES['operation_list']
	num1 = ask MESSAGES['ask_2']

	loop do
		num2 = ask (MESSAGES['ask_3'])
		if operation == "/" && num2.to_i == 0
			puts (MESSAGES['zero_div'])
			next
		else
			break
		end
	end

	output = case operation

		         when "+"
			         message = (MESSAGES['add'])
			         num1.to_f + num2.to_f
		         when "-"
			         message = (MESSAGES['subtract'])
			         num1.to_f - num2.to_f
		         when "*"
			         message = (MESSAGES['multiply'])
			         num1.to_f * num2.to_f
		         when "/"
			         message = (MESSAGES['divide'])
			         num1.to_f / num2.to_f
		         else
			         puts (MESSAGES['error_message'])
	         end

	puts operation
	puts "#{num1} #{operation} #{num2}" + (MESSAGES['final_message']) + "#{output}!"
	puts (MESSAGES['repeat_request'])
	answer = gets.chomp.downcase
	break unless answer == "yes"
end
