num = "716892543"
cups = num.chars.map(&:to_i)

def play_round(cups)
  current = cups[0]
  removed = cups[1..3]
  cups = [cups[0]] + cups[4..]
  dest = nil
  t = current - 1
  while dest == nil
    dest = cups.index(t)
    t -= 1
    if t < cups.min
      t = cups.max
    end
  end
  cups[1..dest] + removed + cups[dest+1..-1] + [cups[0]]
end

0.upto(99) do |a|
  cups = play_round(cups)
end
cups = cups.rotate while cups[-1] != 1
puts cups[0..-2].join


#--------
# Part 2
#--------
class Node
  attr_accessor :prev, :nxt, :value
  def initialize(value)
    @value = value
  end
end

def play_list_round(head)
  removed_start = head.nxt
  removed_end = head.nxt.nxt.nxt
  head.nxt = removed_end.nxt
  dest = removed_end.nxt
  t = head.value - 1
  t = 1000000 if t == 0
  forbidden_ts = [removed_start.value, removed_start.nxt.value, removed_end.value]
  while forbidden_ts.include?(t)
    t -= 1
    t = 1000000 if t == 0
  end
  dest = @nodes[t]
  removed_end.nxt = dest.nxt
  dest.nxt = removed_start
end

num = "716892543"
cups = num.chars.map(&:to_i)
@nodes = {}
head = Node.new(cups[0])
@nodes[cups[0]] = head
prev = head
cups[1..].each do |c|
  @nodes[c] = Node.new(c)
  prev.nxt = @nodes[c]
  prev = @nodes[c]
end

(cups.length+1).upto(1000000) do |i|
  @nodes[i] = Node.new(i)
  prev.nxt = @nodes[i]
  prev = @nodes[i]
end
prev.nxt = head

1.upto(10000000) do |a|
  play_list_round(head)
  head = head.nxt
end

one = @nodes[1]

puts one.nxt.value * one.nxt.nxt.value