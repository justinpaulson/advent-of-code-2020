lines = File.readlines(ARGV[0])

## I did this whole damn thing trying to just check for abc xyz because i misunderstood the input.
## -1000 reading comprehension :(


passes = []
index = 0
lines.each do |line|
  if line[0] != "\n"
    passes[index] ||= ''
    passes[index] += line.chomp
  else
    passes[index] = passes[index].chars.uniq.join
    index +=1
  end
end
passes[index] = passes[index].chars.uniq.join

passes = passes.join
puts passes.length

groups = []
index = 0
lines.each do |line|
  if line[0] != "\n"
    groups[index] ||= []
    groups[index] << line.chomp.chars.uniq.sort.join
  else
    index += 1
  end
end

outs = []
groups.each do |gr|
  ans = ""
  gr[0].chars.each do |c|
    val = true
    gr[1..].each do |m|
      if !m.chars.include?(c)
        val = false
        break
      end
    end
    ans += c if val
  end
  outs << ans
end
puts outs.join.length
