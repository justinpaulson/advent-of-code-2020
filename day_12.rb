lines = File.readlines(ARGV[0]).map(&:chomp).map{|l| [l[0], l[1..].to_i]}
x = 0
y = 0

dir = "E"

lines.each do |m, num|
  case m
  when 'N'
    y += num
  when 'S'
    y -= num
  when 'E'
    x += num
  when 'W'
    x -= num
  when 'L'
    turns = num / 90
    1.upto(turns) do |l|
      case dir
      when 'E'
        dir = 'N'
      when 'W'
        dir = 'S'
      when 'N'
        dir = 'W'
      when 'S'
        dir = 'E'
      end
    end
  when 'R'
    turns = num / 90
    1.upto(turns) do |l|
      case dir
      when 'E'
        dir = 'S'
      when 'W'
        dir = 'N'
      when 'N'
        dir = 'E'
      when 'S'
        dir = 'W'
      end
    end
  when 'F'
    case dir
    when 'E'
      x += num
    when 'W'
      x -= num
    when 'N'
      y += num
    when 'S'
      y -= num
    end
  end

end

puts x.abs + y.abs

waypoint = [1,10]
x = 0
y = 0

lines.each do |m, num|
  case m
  when 'N'
    waypoint[0] += num
  when 'S'
    waypoint[0] -= num
  when 'E'
    waypoint[1] += num
  when 'W'
    waypoint[1] -= num
  when 'L'
    turns = num / 90
    1.upto(turns) do |l|
      waypoint = [waypoint[1],-waypoint[0]]
    end
  when 'R'
    turns = num / 90
    1.upto(turns) do |l|
      waypoint = [-waypoint[1],waypoint[0]]
    end
  when 'F'
    x += num * waypoint[1]
    y += num * waypoint[0]
  end
end

puts x.abs + y.abs