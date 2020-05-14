def substrings(string)
  substring_array = []
  begin_counter = 0
  end_counter = begin_counter + 1
  until begin_counter > string.length - 1
    until end_counter > string.length - 1
      substring_array.push(string[begin_counter..end_counter])
      end_counter += 1
    end
    begin_counter += 1
    end_counter = begin_counter + 1
  end
  substring_array
end

def palindrome?(sub_string)
  sub_string = sub_string.downcase
  sub_string.each_char do |char|
    sub_string.delete!(char) if !("a".."z").cover?(char)
  end
  sub_string == sub_string.reverse
end

def palindromes(string)
  substrings = substrings(string)
  substrings.select do |substring|
    palindrome?(substring)
  end
end

puts palindromes("ylyf")
