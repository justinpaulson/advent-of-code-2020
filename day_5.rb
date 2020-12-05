grid = File.readlines(ARGV[0])
max = 0
ids = []
grid.each do |c|

  ## HOW I SOLVED IT
  rows = [*0..127]
  c[0..6].chars.each do |l|
    if l=="F"
      rows = rows[0..rows.length/2-1]
    else
      rows = rows[rows.length/2..]
    end
  end
  row = rows[0]

  cols = [*0..7]
  c[7..].chars.each do |l|
    if l=="L"
      cols = cols[0..cols.length/2-1]
    else
      cols = cols[cols.length/2..]
    end
  end
  col = cols[0]

  ##  VERY ANGRY REFACTOR BECAUSE I DID THIS FIRST WITH THE WRONG RANGE :*( !!!!
  row=c[0..6].gsub('F','0').gsub('B','1').to_i(2)
  col=c[7..].gsub('L','0').gsub('R','1').to_i(2)
  id = row * 8 + col

  ids << id
  max = [max,id].max
end

puts max

poss = []
ids.each do |s|
  ids.each do |t|
    if s == t-2
      poss << s-1 unless ids.include?(s-1)
    elsif s == t+2
      poss << s+1 unless ids.include?(s+1)
    end
  end
end

me = poss.sort[1..-2][0]

puts me
