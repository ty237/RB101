def rotate_array(array)
  array[1..-1] + array[0]
end

def rotate_rightmost_digits(number, digits)
  number = number.to_s
  digits += 1
  unchanged = number[0..-digits]
  to_be_rotated = number[digits..-1]
  array = to_be_rotated.chars
  rotated = rotate_array(array)
  rotated.join
  (unchanged + rotated).to_i
end

rotate_rightmost_digits(735291, 3)