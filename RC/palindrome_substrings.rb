def substring(string)
  substrings = []
  start_index = 0
  end_index = start_index + 1
  while start_index < string.length
    until end_index == string.length
      substrings.push(string[start_index..end_index])
      end_index += 1
    end
    start_index += 1
    end_index = start_index + 1
  end
  substrings
end

def palindrome?(str)
  str == str.reverse
end

def palindrome_substring(str)
  substrings = substring(str)
  substrings.select { |str| palindrome?(str) }.to_a
end

p palindrome_substring("supercalifragilisticexpialidocious") == ["ili"]
p palindrome_substring("abcddcbA") == ["bcddcb", "cddc", "dd"]
p palindrome_substring("palindrome")
p palindrome_substring("") == []