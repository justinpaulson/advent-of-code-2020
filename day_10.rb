lines = File.readlines(ARGV[0]).map(&:to_i)
lines = lines.sort
rating = lines[-1] + 3

os = lines[0]
ts = 0
lines.each_with_index do |line, i|
  if i<lines.length-1
    if lines[i+1]-line==1
      os += 1
    elsif lines[i+1]-line == 3
      ts += 1
    end
  else
    if rating - line == 1
      os +=1
    elsif rating - line == 3
      ts += 1
    end
  end
end
puts os * ts

@answers = {}

def get_next_options(lines, index)
  return @answers[index] if @answers[index]
  total = 1
  if index < lines.length - 1
    total = get_next_options(lines, index+1)
  end
  if index < lines.length - 2 && lines[index+2] <= lines[index]+3
    total += get_next_options(lines, index+2)
  end
  if index < lines.length - 3 && lines[index+3] <= lines[index]+3
    total += get_next_options(lines, index+3)
  end
  @answers[index] = total
  return total
end

options = []
index = 0
plug = 0
jolt = plug

puts get_next_options(lines, 0) + get_next_options(lines, 1) + get_next_options(lines, 2)