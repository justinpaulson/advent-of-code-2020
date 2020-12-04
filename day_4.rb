lines = File.readlines(ARGV[0]).map &:chomp

passes = []
index = 0
lines.each do |line|
  if line.length > 0
    passes[index] ||= []
    passes[index] += line.split(' ')
  else
    index +=1
  end
end
passes = passes.map{|p| p.map{|k| k.split(":")}}

keys = ["byr", "iyr","eyr","hgt","hcl","ecl","pid"]
valid_passes = []
passes.map do |pass|
  val = true
  keys.each do |k|
    val = false unless pass.map{|k,v| k}.include?(k)
  end
  valid_passes << pass if val
end

puts "Part 1: #{valid_passes.count}"

t = 0
valid_passes.map do |pass|
  val = true
  pass.each do |k,v|
    case k
    when "byr"
      val = false if v.to_i < 1920 || v.to_i > 2002
    when "iyr"
      val = false if v.to_i < 2010 || v.to_i > 2020
    when "eyr"
      val = false if v.to_i < 2020 || v.to_i > 2030
    when "hgt"
      val = false unless v.match(/[0-9]+(cm|in)/)
      num = v[0..-2].to_i
      case v[-2..]
      when 'cm'
        val = false if num < 150 || num > 193
      when 'in'
        val = false if num < 59 || num > 76
      end
    when "hcl"
      val = false unless v.length == 7 && v.match(/#[0-9a-f]{6}/)
    when "ecl"
      val = false unless ["amb","blu","brn","gry","grn","hzl","oth"].include?(v)
    when "pid"
      val = false unless v.length == 9 && v.match(/[0-9]{9}/)
    end
  end
  t+=1 if val
end

puts "Part 2: #{t}"