lines = File.readlines(ARGV[0]).map(&:chomp)

t = []
lines.each do |line|
  l = nil
  l2 = nil
  l3 = nil
  op = nil
  op2 = nil
  op3 = nil
  line.split(' ').each do |a|
    if a.to_i.to_s == a
      if l3
        l3 += a.to_i if op3 == '+'
        l3 *= a.to_i if op3 == '*'
      elsif l2
        l2 += a.to_i if op2 == '+'
        l2 *= a.to_i if op2 == '*'
      elsif l
        l += a.to_i if op == '+'
        l *= a.to_i if op == '*'
      else
        l = a.to_i
      end
    elsif a == '+' || a == '*'
      if l3
        op3 = a
      elsif l2
        op2 = a
      else
        op = a
      end
    elsif a[0]=='('
      if a[1] == '('
        l3 = a[2..].to_i
      else
        if l2
          l3 = a[1..].to_i
        else
          l2 = a[1..].to_i
        end
      end
    elsif a[-1]==')'
      if a[-2]==')'
        if l2 && !l
          l3 += a[0..-2].to_i if op3 == '+'
          l3 *= a[0..-2].to_i if op3 == '*'
          l2 += l3 if op2 == '+'
          l2 *= l3 if op2 == '*'
          l = l2
          l2 = nil
          l3 = nil
        elsif l2 && l
          l3 += a[0..-2].to_i if op3 == '+'
          l3 *= a[0..-2].to_i if op3 == '*'
          l2 += l3 if op2 == '+'
          l2 *= l3 if op2 == '*'
          l += l2 if op == '+'
          l *= l2 if op == '*'
          l2 = nil
          l3 = nil
        else
          l3 += a[0..-2].to_i if op3 == '+'
          l3 *= a[0..-2].to_i if op3 == '*'
          l += l3 if op == '+'
          l *= l3 if op == '*'
          l3 = nil
        end
      else
        if l3 && !l2
          l3 += a[0..-2].to_i if op3 == '+'
          l3 *= a[0..-2].to_i if op3 == '*'
          l2 = l3
          l3 = nil
        elsif l3 && l2
          l3 += a[0..-2].to_i if op3 == '+'
          l3 *= a[0..-2].to_i if op3 == '*'
          l2 += l3 if op2 == '+'
          l2 *= l3 if op2 == '*'
          l3 = nil
        elsif l2 && !l
          l2 += a[0..-2].to_i if op2 == '+'
          l2 *= a[0..-2].to_i if op2 == '*'
          l = l2
          l2 = nil
        else
          l2 += a[0..-2].to_i if op2 == '+'
          l2 *= a[0..-2].to_i if op2 == '*'
          l += l2 if op == '+'
          l *= l2 if op == '*'
          l2 = nil
        end
      end
    end
  end
  t << l
end

puts t.sum

new_lines = []
while lines.flatten.join.chars.include?('+')
  while !lines.flatten.join.scan(/([0-9]+(?: \+ [0-9]+)+)/).empty?
    new_lines = []
    lines.each do |line|
      new_lines << line.gsub(/([0-9]+(?: \+ [0-9]+)+)/){eval($1)}.gsub(/\(([0-9]+)\)/, '\1')
    end
    lines = new_lines
  end
  while !lines.flatten.join.scan(/(\([0-9]+(?: \* [0-9]+)+\))/).empty?
    new_lines = []
    lines.each do |line|
      new_lines << line.gsub(/\(([0-9]+(?: \* [0-9]+)+)\)/){eval($1)}
    end
    lines = new_lines
  end
  new_lines = []
  lines.each do |line|
    if !line.match(/\+/)
      new_lines << eval(line).to_s
    else
      new_lines << line
    end
  end
  lines = new_lines
end

puts lines.sum &:to_i