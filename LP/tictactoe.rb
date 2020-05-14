require 'pry'
puts "----------Welcome to Tik Tak Toe!----------"
POSSIBLE_INPUTS = [1, 2, 3, 4, 5, 6, 7, 8, 9]
INITIAL_MARKER = ' '
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                [[1, 5, 9], [3, 5, 7]]

def x_or_o
  type = nil
  loop do
    puts "Type O if you would like to play with O's. Otherwise type X."
    type = gets.chomp.downcase
    break if type == 'x' || type == 'o'
    puts "Invalid input! Please type \"X\" or \"O\""
  end
  type.upcase
end

def alternate_player(current_player)
  if current_player == 'Computer'
    'User'
  else
    'Computer'
  end
end

def join_or(array)
  if array.size == 1
    return array.join
  end
  *rest, last = array
  "#{rest.join(', ')} or #{last}"
end

def find_computer_marker
  if USER_MARKER == "O"
    "X"
  else
    "O"
  end
end

USER_MARKER = x_or_o
COMPUTER_MARKER = find_computer_marker

def offensive_move(board)
  WINNING_LINES.each do |line|
    if board.values_at(line[0], line[1], line[2]).count(COMPUTER_MARKER) == 2
      return (line.select { |num| board[num] == ' ' }).join.to_i
    end
  end
  nil
end

def defensive_move(board)
  WINNING_LINES.each do |line|
    if board.values_at(line[0], line[1], line[2]).count(USER_MARKER) == 2
      square = (line.select { |num| board[num] == ' ' }).join.to_i
      return square unless square == 0
    end
  end
  nil
end

def computer_places_piece!(board)
  square = offensive_move(board)
  square = defensive_move(board) if square.nil?
  square = empty_squares(board).sample if square.nil?
  board[square] = COMPUTER_MARKER
end

def valid?(square, board)
  empty_squares(board).include?(square.to_i) && square.to_f % 1 == 0
end

def prompt(msg)
  puts "=> #{msg}"
end

# rubocop:disable Metrics/AbcSize
def display_board(brd)
  system 'clear'
  puts "You're a #{USER_MARKER}. Computer is a #{COMPUTER_MARKER}."
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def empty_squares(board)
  board.keys.select { |num| board[num] == INITIAL_MARKER }
end

def player_places_piece!(board)
  square = nil
  loop do
    prompt "Choose a square (#{join_or(empty_squares(board))})"
    square = gets.chomp
    break if valid?(square, board)
    puts "That was invalid input."
  end
  board[square.to_i] = USER_MARKER
end

def board_full?(board)
  empty_squares(board).empty?
end

def someone_won?(board)
  !!detect_winner(board)
end

def display_results(board)
  if someone_won?(board)
    puts "#{detect_winner(board)} won!"
  else
    puts "It was a tie!"
  end
end

def detect_winner(board)
  WINNING_LINES.each do |line|
    if board.values_at(*line).count(USER_MARKER) == 3
      return "You "
    elsif board.values_at(*line).count(COMPUTER_MARKER) == 3
      return "Computer "
    end
  end
  nil
end

def place_piece!(board, current_player)
  if current_player == 'Computer'
    computer_places_piece!(board)
  else
    player_places_piece!(board)
  end
end

def main_game_loop
  board = initialize_board
  display_board(board)
  current_player = 'Computer'

  loop do
    current_player = alternate_player(current_player)
    place_piece!(board, current_player)
    puts board
    display_board(board)
    break if someone_won?(board) || board_full?(board)
  end

  display_results(board)
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

loop do
  main_game_loop
  repeat = play_again?
  break if repeat == false
end

puts "----------Thanks for playing to Tik Tak Toe!----------"
