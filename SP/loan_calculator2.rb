puts "------------Welcome to Mortgage Calculator------------"

def valid_loan_or_apr(input)
  return true if input == input.to_f.to_s || input == input.to_i.to_s
  false
end

def valid_duration(input)
  return true if input == input.to_i.to_s
  false
end

def valid_new_calc(answer)
  if answer == "y" || answer == "yes"
    true
  elsif answer == "n" || answer == "no"
    false
  end
end

def valid_input?(input, input_type)
  if input.to_f < 0 || input.to_i == 0 || input.empty?
    return false
  end
  case input_type
  when "loan_amt"
    return valid_loan_or_apr(input)
  when "apr"
    return valid_loan_or_apr(input)
  when "duration"
    return valid_duration(input)
  when "new_calc"
    return valid_new_calc(input)
  else
    false
  end
end

def retrieve_input(input_type)
  input = nil
  loop do
    input = gets.chomp
    break if valid_input?(input, input_type)
    puts "That was invalid input and invalid input includes 0!"
  end
  input
end

def new_calculation?
  loop do
    answer = gets.chomp.downcase
    if answer == "y" || answer == "yes"
      return true
    elsif answer == "n" || answer == "no"
      return false
    else
      puts "Invalid input. Try again."
      next
    end
  end
end

def calculate_monthly_payment(p, j, n)
  m = (p * (j / (1 - (1 + j)**-n)))
  "$" + m.round(2).to_s
end

apr = <<~APR
  What is the Annual Percentage Rate(APR)?
  If it is 5% just type 5,
     for 2.5% just type 2.5.
APR
loop do
  puts "How much is the loan for?"
  loan_amount = retrieve_input("loan_amt").to_f
  puts apr
  apr = retrieve_input("apr").to_f / 100 / 12
  puts "How many whole years do you have to pay off the loan?"
  duration = retrieve_input("duration").to_i * 12
  monthly_payment = calculate_monthly_payment(loan_amount, apr, duration)

  puts "Your loan duration in months is #{duration.to_i}."
  puts "Your monthly payment is #{monthly_payment}."
  puts "=> Would you like to make another calculation?"
  break if new_calculation? != true
  system('clear')
end
puts "-----Thank you for using Mortgage Calculator-----"
