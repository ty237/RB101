def staggered_case(string, staggered = "y")
  string = string.downcase
  array = []
  type = 0
  string.each_char do |char|
    if !("a".."z").cover?(char) && staggered == "y"
      array.push(char)
      next
    end
    if type == 1
      array.push(char.downcase)
      type = 0
    else
      array.push(char.upcase)
      type = 1
    end
  end
  array.join
end

puts staggered_case('I Love Launch School!', "n") == 'I LoVe lAuNcH ScHoOl!'
puts staggered_case('ALL_CAPS', "n") == 'AlL_CaPs'
puts staggered_case('ignore 77 the 444 numbers', "n") == 'IgNoRe 77 ThE 444 NuMbErS'
