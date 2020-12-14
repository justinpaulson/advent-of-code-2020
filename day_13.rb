lines = File.readlines(ARGV[0]).map(&:chomp)
t = lines[0].to_i

buses = lines[1].split(',').select{|c| c!='x'}.sort.map &:to_i

bus = 0
wait = 999
buses.each do |b|
  w = (b - t % b)
  if w < wait
    bus = b
    wait = w
  end
end

puts bus * wait

def works? (bs, t)
  bs.each_with_index do |n, i|
    next if n == 'x'
    return false unless (t+i) % (n.to_i)==0  
  end
  true
end

bs = lines[1].split(',')
t = 1487993660   # number derived from finding first solution of a partial set
ts = []
big_b = 1804543183 # number derived from finding difference in first few solutions of a partial set
first = bs[0].to_i
while ts.length < 4
  t += big_b
  break if works? bs, t
end

puts t