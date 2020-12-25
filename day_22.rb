def run_round(p1, p2, recur=false)
  if recur && p1[0] <= p1.length-1 && p2[0] <= p2.length-1
    @hands = []
    @game = 0
    @hands[@game] = [p1.clone]
    if run_subgame(p1[1..p1[0]], p2[1..p2[0]]) == 1
      p1 = p1[1..] + [p1[0]] + [p2[0]]
      p2 = p2[1..]
    else
      p2 = p2[1..] + [p2[0]] + [p1[0]]
      p1 = p1[1..]
    end
    [p1, p2]
  else
    if p1[0]>p2[0]
      p1 = p1[1..] + [p1[0]] + [p2[0]]
      p2 = p2[1..]
    else
      p2 = p2[1..] + [p2[0]] + [p1[0]]
      p1 = p1[1..]
    end
    [p1, p2]
  end
end

def run_subgame(p1, p2)
  if p1[0] <= p1.length-1 && p2[0] <= p2.length-1
    @game+=1
    @hands[@game] = [p1.clone]
    if run_subgame(p1[1..p1[0]], p2[1..p2[0]]) == 1
      p1 = p1[1..] + [p1[0]] + [p2[0]]
      p2 = p2[1..]
    else
      p2 = p2[1..] + [p2[0]] + [p1[0]]
      p1 = p1[1..]
    end
    run_subgame(p1, p2)
  else
    if p1[0]>p2[0]
      p1 = p1[1..] + [p1[0]] + [p2[0]]
      p2 = p2[1..]
    else
      p2 = p2[1..] + [p2[0]] + [p1[0]]
      p1 = p1[1..]
    end
    if p1.length < 1
      @game -= 1
      return 2
    elsif p2.length < 1
      @game -= 1
      return 1
    else 
      if @hands[@game].include?(p1)
        @game -= 1
        return 1
      end
    end
    @hands[@game] << p1.clone
    run_subgame(p1, p2)
  end
end

@hands = []

p1,p2 = File.read(ARGV[0]).split("\n\n")
p1 = p1.split("\n")[1..].map &:to_i
p2 = p2.split("\n")[1..].map &:to_i

while !p1.empty? && !p2.empty?
  p1, p2 = run_round(p1, p2)
end
cards = []
cards = p1 if p1.count > 0
cards = p2 if p2.count > 0
t = 0
cards.reverse.each_with_index do |c, i|
  t += c * (i+1)
end
puts t

p1,p2 = File.read(ARGV[0]).split("\n\n")
p1 = p1.split("\n")[1..].map &:to_i
p2 = p2.split("\n")[1..].map &:to_i

while !p1.empty? && !p2.empty?
  p1, p2 = run_round(p1, p2, true)
end
cards = []
cards = p1 if p1.count > 0
cards = p2 if p2.count > 0
t = 0
cards.reverse.each_with_index do |c, i|
  t += c * (i+1)
end
puts t