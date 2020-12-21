rules = File.readlines(ARGV[0]).map(&:chomp)
lines = File.readlines(ARGV[1]).map(&:chomp)
rules = rules.sort_by{|r| r.split(':')[0].to_i}

roots = []
rules = rules.map do |r|
  i, rule = r.split(': ')
  if rule[0]=='"'
    rule = rule[1]
    roots << i.to_i
  end
  rule
end

# roots.each do |root|
#   rules = rules.map do |r|
#     r.gsub(root.to_s, rules[root])
#   end
# end

rules = rules.map do |r|
  r = "(#{r})" if r.chars.include?('|')
  r
end

while rules.join.match(/[0-9]/)
  rules = rules.map do |r|
    r.scan(/[0-9]+/) do |ind|
      puts ind
      r = r.gsub(ind, "#{rules[ind.to_i]}") unless rules[ind.to_i].match(/[0-9]/)
    end
    r
  end
end

rules = rules.map{|r| r.gsub(' ','')}
# puts rules.to_s
puts rules[0]
puts rules[8]
puts rules[42]

puts lines.sum{|l| l.match("^#{rules[0]}$") ? 1 : 0}

# puts lines.map{|l| l.length == "abbabbbbbbbbbaaabaaaaaaa".length ? 1 : 0}.sum



###  319 is wrong!
## 110 too low
## 111 -  wrong
## 112 -  wrong
## 117 -  wrong

## 118 - Correct --- 

## 125 -  wrong
## 140 too high