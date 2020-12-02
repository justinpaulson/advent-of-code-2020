passes = File.readlines(ARGV[0]).map{|i| i.split ": "}
t = 0
l = 0
passes.each do |p|
  pass = p[1]
  range, letter = p[0].split " "
  low, high = range.split("-").map &:to_i
  t+=1 if pass.count(letter) >= low && pass.count(letter) <= high
  l+=1 if (pass[high-1]!=letter && pass[low-1]==letter) || (pass[high-1]==letter && pass[low-1]!=letter)
end

puts t
puts l
