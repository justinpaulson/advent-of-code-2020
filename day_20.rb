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
  tile.map{|t| t.chars}.transpose.map{|t| t.join.reverse}
end

def print_tile(tile)
  tile.each{|l| puts l}
end

def match_tile_right(tile_1, tile_2)
  return false if tile_1 == tile_2
  right_match = right tile_1
  match = nil
  r = 0
  while !match && r < 4
    match = tile_2 if left(tile_2) == right_match
    r += 1
    tile_2 = rotate tile_2
  end
  unless match
    tile_2 = flip_v tile_2
    r = 0
    while !match && r < 4
      match = tile_2 if left(tile_2) == right_match
      r += 1
      tile_2 = rotate tile_2
    end
  end
  match
end

def match_tile_bottom(tile_1, tile_2)
  return false if tile_1 == tile_2
  bottom_match = bottom tile_1
  match = nil
  r = 0
  while !match && r < 4
    match = tile_2 if top(tile_2) == bottom_match
    r += 1
    tile_2 = rotate tile_2
  end
  unless match
    tile_2 = flip_v tile_2
    r = 0
    while !match && r < 4
      match = tile_2 if top(tile_2) == bottom_match
      r += 1
      tile_2 = rotate tile_2
    end
  end
  match
end

def create_grid(corners, tiles)
  grid_size = Math.sqrt(tiles.count)
  grid = {}
  x, y = 0, 0
  grid[[y,x]] = tiles[corners.last]
  tiles.delete(corners.last)
  while y < grid_size
    while x < grid_size-1
      tile_match = nil
      match_key = nil
      r = 0
      while !tile_match && r < 4
        tiles.each{|k,v| match_key,tile_match = k,match_tile_right(grid[[y,x]], v) if match_tile_right(grid[[y,x]], v)}
        unless tile_match
          r += 1
          grid[[y,x]] = rotate grid[[y,x]]
        end
      end
      x += 1
      tiles.delete(match_key)
      grid[[y,x]] = tile_match
    end
    break if y > 10
    x = 0
    tile_match = nil
    match_key = nil
    tiles.each{|k,v| match_key,tile_match = k,match_tile_bottom(grid[[y,x]], v) if match_tile_bottom(grid[[y,x]], v)}
    tiles.delete(match_key)
    if !tile_match && y==0
      0.upto(grid_size-1){|b| grid[[y,b]] = flip_v(grid[[y,b]])}
      tiles.each{|k,v| match_key,tile_match = k,match_tile_bottom(grid[[y,x]], v) if match_tile_bottom(grid[[y,x]], v)}
      tiles.delete(match_key)
    end
    y += 1
    grid[[y,x]] = tile_match if y < grid_size
  end
  tile_grid = []
  0.upto(grid_size-1) do |y|
    1.upto(grid[[y,0]].length-2) do |i|
      line = ""
      0.upto(grid_size-1) do |x|
        line += grid[[y,x]][i][1..-2]
      end
      tile_grid << line
    end
  end
  tile_grid
end

ts = File.read(ARGV[0]).split("\n\n")

ts = ts.map{|t| t.lines.map(&:chomp)}
ts = ts.map{|t| t[0] = t[0].match(/[0-9]+/)[0].to_i; t}
tiles = {}
ts.each do |t|
  tiles[t[0]] = t[1..]
end

tile_edges = {}
tiles.each do |k,tile|
  edges = tile_edges(tile)
  tiles.each do |j, tile_inner|
    edges -= tile_edges(tile_inner) if j != k
  end
  tile_edges[k] = edges
end

corners = tile_edges.select{|k,v| v.count > 2}.keys

puts corners.inject(:*)

# sea monster
#
#                     #
#  /#....##....##....###/
#   /#..#..#..#..#..#/

tile_grid = create_grid(corners, tiles)

dragons = []
r = 0
while dragons.count < 1 && r < 4
  r += 1
  tile_grid = rotate(tile_grid)
  top_indexes, mid_indexes, bottom_indexes = [],[],[]
  1.upto(tile_grid.length - 2).each do |i|
    top_indexes = tile_grid[i-1].gsub(/#/).map{ Regexp.last_match.begin(0) }
    mid_indexes = tile_grid[i].gsub(/#....##....##....###/).map{ Regexp.last_match.begin(0) }
    bottom_indexes = tile_grid[i+1].gsub(/#..#..#..#..#..#/).map{ Regexp.last_match.begin(0) }
    mid_indexes.each do |mid_index|
      bottom_indexes.each do |bottom_index|
        dragons << [i,bottom_index] if mid_index + 1 == bottom_index && top_indexes.include?(bottom_index + 17)
      end
    end
  end
end

if dragons.count < 1
  tile_grid = flip_v(tile_grid)
  r = 0
end

while dragons.count < 1 && r < 4
  r += 1
  tile_grid = rotate(tile_grid)
  top_indexes, mid_indexes, bottom_indexes = [],[],[]
  1.upto(tile_grid.length - 2).each do |i|
    top_indexes = tile_grid[i-1].gsub(/#/).map{ Regexp.last_match.begin(0) }
    mid_indexes = tile_grid[i].enum_for(:scan, /(?=(#....##....##....###))/).map { Regexp.last_match.begin(0) }
    bottom_indexes = tile_grid[i+1].enum_for(:scan, /(?=(#..#..#..#..#..#))/).map { Regexp.last_match.begin(0) }
    mid_indexes.each do |mid_index|
      bottom_indexes.each do |bottom_index|
        dragons << [i,bottom_index] if mid_index + 1 == bottom_index && top_indexes.include?(bottom_index + 17)
      end
    end
  end
end

puts tile_grid.join.count('#') - (dragons.count * 15)