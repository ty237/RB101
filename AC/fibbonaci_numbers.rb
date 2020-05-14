def fibbonaci_numbers(how_many)
  fibbonaci_numbers = []
  how_many.times do
    if fibbonaci_numbers[-2].nil?
      fibbonaci_numbers.push(1)
      next
    end
    new_num = fibbonaci_numbers[-1] + fibbonaci_numbers[-2]
    fibbonaci_numbers.push(new_num)
  end
  fibbonaci_numbers
end

puts fibbonaci_numbers(5)
