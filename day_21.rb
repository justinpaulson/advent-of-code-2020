lines = File.readlines(ARGV[0])

as = []

lines.each do |line|
  ints, allers = line.split(" (contains ")
  allers = allers.split(")")[0].split(', ')
  as << [ints, allers]
end

all_allers = as.map{|a| a[1]}.flatten.uniq

possible_allers = {}

all_allers.each do |a|
  as.each do |ints, allers|
    if allers.include?(a)
      if(possible_allers[a])
        possible_allers[a] = possible_allers[a].select{|a| ints.split(' ').include?(a)}
      else
        possible_allers[a] = ints.split(' ')
      end
    end
  end
end

puts as.map{|a| a[0].split(' ')}.flatten.map{|a| !possible_allers.values.flatten.uniq.include?(a) ? 1 : 0}.sum

while possible_allers.any?{|k,v| v.count > 1}
  all_allers.each do |a|
    if possible_allers[a].count == 1
      all_allers.each do |b|
        possible_allers[b] -= possible_allers[a] if b != a
      end
    end
  end
end

puts possible_allers.to_a.sort_by{|a| a[0]}.map{|a| a[1][0]}.join(",")