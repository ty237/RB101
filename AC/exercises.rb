require 'pry'
def center_of(string)
  length = string.length
  if length.even?
    string.slice(length / 2 - 1, 2)
  else
    middle = (length / 2)
    string[middle]
  end
end

puts center_of('I love ruby') == 'e'
binding.pry
puts center_of('Launch School') == ' '
puts center_of('Launch') == 'un'
puts center_of('Launchschool') == 'hs'
puts center_of('x') == 'x'
