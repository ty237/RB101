puts "------------Welcome to Calculator-------------"
VALID_CHOICES = %W[paper scissors rock spock lizard]
user = 0
computer = 0

def get_name
  puts "What is your name?"
  name = gets.chomp
  puts "Welcome #{name}!"
  name
end

def play_again
  puts "Would you like to play again?"
  gets.chomp.downcase
end

def win?(player, player2)
  (player2 == "rock" && (player == "paper" || player == "spock")) ||
    (player2 == "scissors" && (player == "rock" || player == "spock")) ||
    (player2 == "paper" && (player == "scissors" || player == "lizard")) ||
    (player2 == "spock" && (player == "lizard" || player == "paper")) ||
    (player2 == "lizard" && (player == "rock" || player == "scissors"))
end

def output(computer_choice, user_choice)
  if win?(user_choice, computer_choice)
    puts "You won because #{user_choice} beats my choice which was #{computer_choice}."
    "user"
  elsif win?(computer_choice, user_choice)
    puts "You lost because my choice of #{computer_choice} beats #{user_choice}."
    "computer"
  else
    puts "It is a tie because I said #{computer_choice} and you said #{user_choice}!"
  end
end

def return_and_print_winner
  user_choice = nil
  computer_choice = VALID_CHOICES.sample
  loop do
    puts "So whats it going to be: #{VALID_CHOICES.join(" or ")}?"
    user_choice = gets.chomp.downcase
    break if VALID_CHOICES.include?(user_choice)
    puts "That was not valid input!"
  end
  output(computer_choice, user_choice)
end

def did_he_win?(user)
  if user >= 5
    puts "Congratulations you are the grand winner!"
  else
    puts "You lost the whole match loser, better luck next time!"
  end
end

name = get_name

loop do
  loop do
    j = return_and_print_winner
    if j == "user"
      user += 1
      break if user == 5
    elsif j == "computer"
      computer += 1
      break if computer == 5
    end
    puts "The current standings are: #{name} with #{user} points and computer with #{computer} points!"
  end

  did_he_win?(user)

  if play_again == "yes"
    user = 0
    computer = 0
    next
  else
    break
  end
end

puts "----------------Thank_You_For_Using_Rock_Paper_Scissors----------------"
