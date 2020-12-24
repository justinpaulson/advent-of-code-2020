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
  " #{rule} "
end

rules = rules.map do |r|
  r = "(#{r})" if r.chars.include?('|')
  r
end

while rules.join.match(/[0-9]+/)
  i = 0
  rules = rules.map do |r|
    r.scan(/[0-9]+/) do |ind|
      unless rules[ind.to_i].match(/[0-9]+/)
        r = r.gsub(/ #{ind} /, " #{rules[ind.to_i]} ")
      end
    end
    i += 1
    r   
  end
end

rules = rules.map{|r| r.gsub(' ','')}

puts lines.sum{|l| l.match("^#{rules[0]}$") ? 1 : 0}

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
  " #{rule} "
end

rules = rules.map do |r|
  r = "(#{r})" if r.chars.include?('|')
  r
end

rules[8] = "#{rules[42]} +"
rules[11] = "(?<a>#{rules[42]} \\g<a>? #{rules[31]})"

while rules.join.match(/[0-9]+/)
  i = 0
  rules = rules.map do |r|
    r.scan(/[0-9]+/) do |ind|
      unless rules[ind.to_i].match(/[0-9]+/)
        r = r.gsub(/ #{ind} /, " #{rules[ind.to_i]} ")
      end
    end
    i += 1
    r   
  end
end

rules = rules.map{|r| r.gsub(' ','')}

puts lines.sum{|l| l.match("^#{rules[0]}$") ? 1 : 0}