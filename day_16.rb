lines = File.readlines(ARGV[0]).map(&:chomp)

rules = []
done_mine = false
got_mine = false
got_nearby = false
me = []
near = []
lines.each do |line|
  next if line == ""
  if got_mine && !done_mine
    done_mine = true
    me = line.split(',').map(&:to_i)
    next
  end
  (got_mine = true; next) if line == "your ticket:"
  if got_nearby
    near << line.split(',').map(&:to_i)
  else
    (got_nearby = true; next) if line == "nearby tickets:"
    rules << line.split(": ")
  end
end
invalids = []
rules = rules.map do |rule|
  [rule[0], rule[1].split(' or ').map{|r| r.split('-').map(&:to_i)}]
end

good_tix = []

near.each do |ticket|
  bad = false
  ticket.each do |num|
    good = false
    rules.each do |r|
      if (r[1][0][0] <= num && num <= r[1][0][1]) || (r[1][1][0] <= num && num <= r[1][1][1])
        good = true
      end
    end
    unless good
      invalids << num
      bad = true
    end
  end
  good_tix << ticket unless bad
end

puts invalids.sum

possible_columns = []
claimed_columns = {}
rules.each_with_index do |r, i|
  possible_columns << 0.upto(near[0].length-1).map{|a| a}
  good_tix.each do |tick|
    tick.each_with_index do |num, ind|
      unless (r[1][0][0] <= num && num <= r[1][0][1]) || (r[1][1][0] <= num && num <= r[1][1][1]) || claimed_columns.values.include?(ind)
        possible_columns[i] -= [ind]
      end
    end
  end
end

while claimed_columns.keys.count < rules.count
  possible_columns.each_with_index do |poss, i|
    if poss.count == 1
      claimed_columns[rules[i][0]] = poss[0]
      0.upto(possible_columns.length-1) do |ind|
        possible_columns[ind] -= [poss[0]]
      end
    end
  end
end

deps = ["departure location","departure station","departure platform","departure track","departure date","departure time"]

t = 1
deps.each do |key|
  t *= me[claimed_columns[key]]
end

puts t

