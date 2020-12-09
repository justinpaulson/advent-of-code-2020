lines = File.readlines(ARGV[0]).map(&:to_i)

PREAMB = 25

index = PREAMB
invalid = 0
while index < lines.length
  num = lines[index]
  pre = lines[index-PREAMB..index-1]
  val = false
  pre.each_with_index do |a, ai|
    pre.each_with_index do |b, bi|
      val = true if a + b == num && ai != bi
    end
  end
  unless val
    invalid = num
    break
  end
  index += 1
end

puts invalid

fin,start = 0,0
lines.each_with_index do |a, i|
  t = a
  start = i
  while t <= invalid
    if t == invalid
      fin = i
      puts lines[start..fin].max + lines[start..fin].min
      return
    end
    i += 1
    t += lines[i]
  end
end
