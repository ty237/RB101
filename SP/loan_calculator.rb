puts "------------Welcome to Mortgage Calculator------------"
loop do

  def get_and_verify_input(message, type = "f")
    num = nil
    loop do
      puts "=> " + message
      num = gets.chomp
      if num.empty?
        puts "You must type something!"
        next
      elsif type == "f" && num == num.to_f.to_s || num == num.to_i.to_s
        num = num.to_f
        break
      elsif type == "i" && num == num.to_i.to_s
        num = num.to_i
        break
      else
        puts "Invalid input or unnecessary zeros in the decimal place."
        next
      end
    end
    num
  end

  apr = <<~APR
    What is the Annual Percentage Rate(APR)?
    If it is 5% just type 5,
       for 2.5% just type 2.5.
  APR

  p = get_and_verify_input("How much is the loan for?", "f")
  j = get_and_verify_input(apr, "f") / 100 / 12
  n = get_and_verify_input("How long is the loan duration in years?", "i") * 12
  m = (p * (j / (1 - (1 + j)**-n)))
  m = "$" + m.round(2).to_s

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
puts "-----Thank you for using Mortgage Calculator-----"
