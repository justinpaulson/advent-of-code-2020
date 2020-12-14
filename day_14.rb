lines = File.readlines(ARGV[0]).map(&:chomp)

mask = ""
m = {}
lines.each do |line|
  if line[0..3] == "mask"
    mask = line.split(" = ")[1].reverse
  else
    mem, num = line.split(" = ")
    num = num.to_i.to_s(2).reverse
    w = ""
    mask.chars.each_with_index do |d,i|
      if d == "X"
        if i < num.length
          w += num[i]
        else
          w+= "0"
        end
      else
        w += d
      end
    end
    w = w.reverse.to_i(2)
    m[mem[4..].split(']')[0].to_i] = w
  end
end

puts m.values.sum

m = {}
lines.each do |line|
  if line[0..3] == "mask"
    mask = line.split(" = ")[1].reverse
  else
    mem, num = line.split(" = ")
    num = num.to_i
    address = mem[4..].split(']')[0].to_i
    addbin = address.to_s(2).reverse
    ws = [""]
    mask.chars.each_with_index do |d,i|
      if d == "0"
        if i < addbin.length
          if ws.length < 1
            ws[0] = "" + addbin[i]
          else
            ws = ws.map{|w| w + addbin[i]}
          end
        else
          ws = ws.map{|w| w + "0"}
        end
      elsif d == "1"
        ws = ws.map{|w| w + d}
      else
        ws = ws.map{|w| w + "1"} + ws.map{|w| w + "0"}
      end
    end
    ws.each do |w|
      m[w.reverse.to_i(2)] = num
    end
  end
end

puts m.values.sum
