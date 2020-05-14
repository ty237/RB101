HC = []
(1..9).each { |n| HC.push(n.to_s) }
("a".."z").each { |n| HC.push(n) }
SECTIONS = [8, 4, 4, 4, 12]

def uuid
  uuid = ""
  SECTIONS.each do |section|
    section.times do
      uuid << HC.sample
    end
    uuid << "-" unless section == 12
  end
  uuid
end

puts uuid
puts uuid
