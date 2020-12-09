lines = File.readlines(ARGV[0]).map(&:chomp).map(&:split)

def get_acc(lines)
  acc=0
  index = 0
  indexes = []
  while(!indexes.include?(index) && index != lines.length)
    indexes << index
    cmd, arg = lines[index]
    case cmd
    when "acc"
      acc += arg.to_i
      index += 1
    when "jmp"
      index += arg.to_i
    when "nop"
      index += 1
    end
  end

  [acc, index==(lines.length)]
end

puts get_acc(lines)[0]

lines.each_with_index do |(c,a),i|
  if c=="jmp"
    if i==0
      ac, i = get_acc([["nop", a]]+lines[i+1..])
      puts ac if i
    else
      ac, i = get_acc(lines[0..i-1]+[["nop", a]]+lines[i+1..])
      puts ac if i
    end
  elsif c=="nop"
    if i==0
      ac, i = get_acc([["jmp", a]]+lines[i+1..])
      puts ac if i
    else
      ac, i = get_acc(lines[0..i-1]+[["jmp", a]]+lines[i+1..])
      puts ac if i
    end
  end
end
