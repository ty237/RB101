puts "------------Welcome to Calculator-------------"
VALID_CHOICES = %w[paper scissors rock spock lizard]
user = 0
computer = 0

def print_and_return_name
  puts "What is your name?"
  name = gets.chomp
  puts "Welcome #{name}!"
  name
end

def valid?(answer)
  case answer
  when "yes"
    true
  when "y"
    true
  when "n"
    true
  when "no"
    true
  else
    false
  end
end

def play_again?
  answer = nil
  loop do
    puts "Would you like to play again?"
    answer = gets.chomp.downcase
    break if valid?(answer)
    puts "Invalid input! Please enter y, yes, n, no."
  end
  answer
end

def win?(player, player2)
  (player2 == "rock" && (player == "paper" || player == "spock")) ||
    (player2 == "scissors" && (player == "rock" || player == "spock")) ||
    (player2 == "paper" && (player == "scissors" || player == "lizard")) ||
    (player2 == "spock" && (player == "lizard" || player == "paper")) ||
    (player2 == "lizard" && (player == "rock" || player == "scissors"))
end

def win_message(computer_choice, user_choice)
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
    puts "So whats it going to be: #{VALID_CHOICES.join(' or ')}?"
    user_choice = gets.chomp.downcase
    break if VALID_CHOICES.include?(user_choice)
    puts "That was not valid input!"
  end
  win_message(computer_choice, user_choice)
end

def total_winner?(user)
  if user >= 5
    puts "Congratulations you are the grand winner!"
  else
    puts "You lost the whole match loser, better luck next time!"
  end
end

def move_on?
  loop do
    puts "Enter any character to move on."
    gets
    break
  end
  system('clear')
end

def game_loop(user, computer)
  name = print_and_return_name
  loop do
    winner = return_and_print_winner
    if winner == "user"
      user += 1
    elsif winner == "computer"
      computer += 1
    end
    puts "The current standings are: #{name} with #{user} points and computer with #{computer} points!"
    break if user == 5 || computer == 5
    move_on?
  end
  total_winner?(user)
end

loop do
  game_loop(user, computer)

  play_again = play_again?
  if play_again == "yes" || play_again == "y"
    user = 0
    computer = 0
    system('clear')
    next
  else
    break
  end
end

puts "----------------Thank_You_For_Using_Rock_Paper_Scissors----------------"
