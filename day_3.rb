grid = File.readlines(ARGV[0]).map(&:chop).map(&:chars)
with_viz=false
l=grid[0].length
g=1
s=[[1,1],[1,3],[1,5],[1,7],[2,1]]
s.each do |rise,run|
  t,y,x=0,0,0
  while y<grid.length-rise
    y+=rise
    x+=run
    t+=1 if grid[y][x%l]=="#"
    puts ((x%l>0 ? (grid[y][0..x%l-1]) : [])+[grid[y][x%l]=="#" ? "X" : "O"]+grid[y][x%l+1..]).join if with_viz
  end
  puts "Slope (#{rise},#{run}): #{t}"
  g*=t
end

puts g