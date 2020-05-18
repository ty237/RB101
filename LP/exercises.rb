# rubocop:disable Metrics/LineLength
require 'pry'
SUITS = %w(H D S C)
VALUES = %w(2 3 4 5 6 7 8 9 Jack King Queen Ace)
MEAN = { 'H' => 'Hearts', 'D' => 'Diamonds',
         'C' => 'Clubs', 'S' => 'Spades' }

DECK = SUITS.product(VALUES)
TOP_VALUE = 21
COMPUTER_TOP_VALUE = 17

def prompt(message)
  puts "=> #{message}"
end

def clear_screen
  system('clear')
end

def continue
  prompt "Press any key to continue"
  gets
end

def play_again?
  answer = nil
  loop do
    prompt "Would you like to play again?"
    answer = gets.chomp.downcase
    break if %w(y n yes no).include?(answer)
    puts "Invalid input! Please put: y, n, yes, no"
  end
  if %(y, yes).include?(answer)
    true
  else
    false
  end
end

def add_aces(total_value, aces)
  if 11 + total_value > TOP_VALUE
    aces.each { |_| total_value += 1 }
  elsif !aces.empty?
    total_value = (aces.size - 1).times { total_value += 1 } + 11
  end
  total_value
end

def total_value(hand)
  numbers = []
  hand.each { |set| numbers.push(set[1]) }
  words, numbers = numbers.partition { |card| %w(Jack King Queen Ace).include?(card) }
  aces, others = words.partition { |card| card == "Ace" }
  numbers.push(others.map { |_| '10' }).flatten!
  numbers.map!(&:to_i) unless numbers.empty?
  total_value = if numbers.empty?
                  0
                else
                  numbers.reduce(&:+)
                end
  add_aces(total_value, aces)
end

def join_and(array, player = 'User')
  cards = array.map do |sub_array|
    "#{sub_array[1]} of #{MEAN[sub_array[0]]}"
  end
  return cards[0] if player != 'User'
  return cards.join if array.size == 1
  *rest, last = cards
  "#{rest.join(', ')} and a #{last}"
end

def initialize_hand
  card1 = DECK.sample
  card2 = nil
  loop do
    card2 = DECK.sample
    break if card1.object_id != card2.object_id
  end
  [card1, card2]
end

def display(user_hand, dealer_hand)
  clear_screen
  puts "Your hand consists of a #{join_and(user_hand)}."
  puts "Your total hand value is #{total_value(user_hand)}."
  puts "The dealer has a #{join_and(dealer_hand, 'Dealer')} and an unknown card."
end

def hit_or_stay
  move = nil
  loop do
    prompt "Would you like to (h)it or (s)tay?"
    move = gets.chomp.downcase
    break if %(h s hit stay).include?(move)
    prompt "Invalid input! Please type: 'h', 'hit', 's' or 'stay'."
  end
  return "hit" if %(h hit).include?(move)
  "stay"
end

def hit(hand, player = 'Dealer')
  new_card = nil
  loop do
    new_card = DECK.sample
    break if hand.all? { |card| new_card.object_id != card.object_id }
  end
  if player == 'user'
    puts "The dealer hits you with a #{join_and([new_card])}"
    continue
  end
  hand.push(new_card)
end

def busted?(user_hand)
  return true if total_value(user_hand) > TOP_VALUE
  false
end

def main_message(user_hand, dealer_hand, dealer_total, user_total)
  clear_screen
  puts "The dealer's cards were a #{join_and(dealer_hand)}."
  puts "Your cards were a #{join_and(user_hand)}."
  puts "The dealer's total was #{dealer_total} while your total was #{user_total}."
end

# rubocop:disable Metrics/MethodLength
def display_and_return_player(user_total, dealer_total)
  if user_total > TOP_VALUE
    puts "So you busted!"
    'Dealer'
  elsif dealer_total > TOP_VALUE
    puts "So the dealer busted and you won!"
    'User'
  elsif user_total > dealer_total
    puts "So you won!"
    'User'
  elsif dealer_total > user_total
    puts "So you lost!"
    'Dealer'
  else
    puts "So it was a tie!"
    nil
  end
end

def display_and_return_winner(user_hand, dealer_hand)
  dealer_total = total_value(dealer_hand)
  user_total = total_value(user_hand)
  main_message(user_hand, dealer_hand, dealer_total, user_total)
  display_and_return_player(user_total, dealer_total)
end

def dealer_turn(dealer_hand)
  loop do
    value = total_value(dealer_hand)
    hit(dealer_hand) if value < COMPUTER_TOP_VALUE
    break if value >= COMPUTER_TOP_VALUE
    puts "The dealer chose to hit!"
  end
  puts "The dealer chose to stay at #{total_value(dealer_hand)}!"
  dealer_hand
end

def dealer_sequence(dealer_hand)
  clear_screen
  puts "The dealer is going . . ."
  hand = dealer_turn(dealer_hand)
  prompt "The dealers turn is over. Press any key to find out who won!"
  gets
  hand
end

def main_game_loop
  dealer_hand = initialize_hand
  user_hand = initialize_hand
  loop do
    clear_screen
    display(user_hand, dealer_hand)
    request = hit_or_stay
    hit(user_hand, 'user') if request == 'hit'
    break if busted?(user_hand) || request == "stay"
  end
  dealer_hand = dealer_sequence(dealer_hand) unless busted?(user_hand)
  winner = display_and_return_winner(user_hand, dealer_hand)
  continue
  winner
end

def final_message(computer, name, user)
  puts "The final score was the dealer with #{computer} points and #{name} with #{user} points!"
  if user == 5
    puts "Congratulation! You won!"
  else
    puts "Better luck next time!"
  end
end

def display_welcome_message
  prompt "Let's play five games of twenty-one! Press any key to continue."
  gets
end

def display_stats(computer, name, user)
  puts "Computer has #{computer} points, and #{name} has #{user} points."
  puts "Press any key to continue"
  gets
end

def update_score(array, current_winner)
  user, computer = array
  if current_winner == 'User'
    user += 1
  elsif current_winner == 'Dealer'
    computer += 1
  end
  [user, computer]
end

# beginning of program
system('clear')
prompt "What is you name?"
name = gets.chomp

loop do
  clear_screen
  display_welcome_message
  user = 0
  computer = 0
  loop do
    system('clear')
    current_winner = main_game_loop
    user, computer = update_score([user, computer], current_winner)
    system('clear')
    break if [user, computer].include?(5)
    display_stats(computer, name, user)
  end
  final_message(computer, name, user)
  repeat = play_again?
  break if repeat == false
end
