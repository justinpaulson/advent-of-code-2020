def tile_edges(tile)
  e = []
  e << tile[0].gsub('#','1').gsub('.','0').to_i(2)
  e << tile[0].reverse.gsub('#','1').gsub('.','0').to_i(2)
  e << tile.last.gsub('#','1').gsub('.','0').to_i(2)
  e << tile.last.reverse.gsub('#','1').gsub('.','0').to_i(2)
  e << tile.map{|t| t[0]}.join.gsub('#','1').gsub('.','0').to_i(2)
  e << tile.map{|t| t[0]}.join.reverse.gsub('#','1').gsub('.','0').to_i(2)
  e << tile.map{|t| t[-1]}.join.gsub('#','1').gsub('.','0').to_i(2)
  e << tile.map{|t| t[-1]}.join.reverse.gsub('#','1').gsub('.','0').to_i(2)
  e
end

def match_left(tile, key)
  if left(tile) == key
    return tile
  else
    r = 0
    while r < 4 
      tile = rotate(tile)
      return tile if left(tile) == key
      r+=1
    end
    tile = flip_h(tile)
    return tile if left(tile) == key
    r = 0
    while r < 4
      tile = rotate(tile)
      return tile if left(tile) == key
      r+=1
    end
    return false
  end
end

def top(tile)
  tile[0].gsub('#','1').gsub('.','0').to_i(2)
end

def bottom(tile)
  tile[-1].gsub('#','1').gsub('.','0').to_i(2)
end

def left(tile)
  tile.map{|t| t[0]}.join.gsub('#','1').gsub('.','0').to_i(2)
end

def right(tile)
  tile.map{|t| t[-1]}.join.gsub('#','1').gsub('.','0').to_i(2)
end

def flip_h(tile)
  tile.map{|t| t.reverse}
end

def flip_v(tile)
  tile.reverse
end

def rotate(tile)
  tile.map{|t| t.chars}.transpose.map{|t| t.join}
end

ts = File.read(ARGV[0]).split("\n\n")

ts = ts.map{|t| t.lines.map(&:chomp)}
ts = ts.map{|t| t[0] = t[0].match(/[0-9]+/)[0].to_i; t}
tiles = {}
ts.each do |t|
  tiles[t[0]] = t[1..]
end

tile_grid = {}
x = 0
y = 0
all_poss = []
tile_grid[[x, y]] = tiles.first

current_tile = tile_grid[[x, y]]
puts tiles.select{|k,t| tile_edges(t).include?(right(current_tile))}.to_s
match_tile = tiles.select{|k,t| tile_edges(t).include?(right(current_tile))}
puts match_tile.values
puts current_tile
puts match_left(match_tile.values, right(current_tile));