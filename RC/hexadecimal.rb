HEXADECIMALS = {
  "1" => 1,
  "2" => 2,
  "3" => 3,
  "4" => 4,
  "5" => 5,
  "6" => 6,
  "8" => 8,
  "9" => 9,
  "a" => 10,
  "b" => 11,
  "c" => 12,
  "d" => 13,
  "e" => 14,
  "f" => 15
}

def hex_to_integer(n)
  n.downcase! if n.class == String
  HEXADECIMALS[n]
end

def hexadecimal_to_integer(hexadecimal)
  array_of_integers = hexadecimal.chars.map { |n| hex_to_integer(n) }
  p array_of_integers
  value = 0
  array_of_integers.each { |n| value = 16 * value + n }
  value
end

puts hexadecimal_to_integer('4D9f') == 19871
