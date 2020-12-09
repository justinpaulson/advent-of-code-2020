def colors_can_hold bags, bag
  colors = []
  bags.each do |b, rules|
    colors << b if rules.map(&:keys).flatten.include?(bag)
  end
  colors
end

def colors_can_hold_with_ruls bags, bag
  colors = []
  bags.each do |b, rules|
    colors << {b => rules} if rules.map(&:keys).flatten.include?(bag)
  end
  colors
end

lines = File.readlines(ARGV[0])
bags = {}

lines.each do |line|
  bag, rules = line.split(" bags contain ")
  rules = rules.split(', ').map{|r| r.split("bag")[0]}.map{|r| {r.split(' ')[1..].join(' ') => r.split(' ')[0].to_i} }
  bags[bag] = rules
  puts bag + bags[bag].to_s
end

# final_colors = []
# check_colors = ['shiny gold']
# while !check_colors.empty?
#   new_checks = []
#   check_colors.each do |color|
#     new_checks += colors_can_hold(bags, color)
#     final_colors += new_checks
#   end
#   check_colors = new_checks
# end

# final_colors = final_colors.uniq

# puts final_colors.count

def number_of_bags(bags, bag)
  return 0 if bags[bag][0].keys.first=="other"
  return bags[bag].map do |b|
    num = b[b.keys[0]]
    # puts num
    num + num *  number_of_bags(bags, b.keys[0])
  end.sum
end

puts number_of_bags(bags, "shiny gold")

