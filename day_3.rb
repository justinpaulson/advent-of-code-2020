grid = File.readlines(ARGV[0]).map(&:chars)
with_viz=true
t1,t2,t3,t4,t5=0,0,0,0,0
current=0
grid = grid[1..]
current =0
grid.each do |line|
  current+=1
  current=current-31 if current>=31
  c = line[current]
  t1+=1 if c=='#'
  r = line[0..current-1]+[c=='#' ? 'X' : 'O']+line[current+1..]
  puts r.join if with_viz
end
current =0
grid.each do |line|
  current+=3
  current=current-31 if current>=31
  c = line[current]
  t2+=1 if c=='#'
  r = line[0..current-1]+[c=='#' ? 'X' : 'O']+line[current+1..]
  puts r.join if with_viz
end
current =0
grid.each do |line|
  current+=5
  current=current-31 if current>=31
  c = line[current]
  t3+=1 if c=='#'
  r = line[0..current-1]+[c=='#' ? 'X' : 'O']+line[current+1..]
  puts r.join if with_viz
end
current =0
grid.each do |line|
  current+=7
  current=current-31 if current>=31
  c = line[current]
  t4+=1 if c=='#'
  r = line[0..current-1]+[c=='#' ? 'X' : 'O']+line[current+1..]
  puts r.join if with_viz
end
grid.each_slice(2) do |_,line|
  current+=1
  current=current-31 if current>=31
  c = line[current]
  t5+=1 if c=='#'
  r = line[0..current-1]+[c=='#' ? 'X' : 'O']+line[current+1..]
  puts r.join if with_viz
end

puts t1
puts t1*t2*t3*t4*t5