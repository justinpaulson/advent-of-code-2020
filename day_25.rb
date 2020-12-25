require 'openssl'

def lp(num, l)
  v = 1
  l.times do 
    v = v * num
    v = v % 20201227
  end
  v
end

door_key, card_key = File.readlines(ARGV[0]).map(&:chomp).map(&:to_i)

# test inputs
# door_key = 5764801
# card_key = 17807724

i=0
door=0
while door != door_key
  # Slow initial way:
  # door = lp(7,i)
  door = 7.to_bn.mod_exp(i,20201227)
  i+=1
end
puts lp(card_key, i-1)