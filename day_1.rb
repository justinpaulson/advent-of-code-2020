exps = File.readlines(ARGV[0]).map(&:to_i)

ans1,ans2 = 0,0
exps.each do |x|
  exps.each do |y|
    ans1=x*y if x+y==2020 && x!=y
    exps.each do |z|
      ans2=x*y*z if x+y+z==2020 && x!=y && x!=z && y!=z
    end
  end
end

puts ans1
puts ans2
