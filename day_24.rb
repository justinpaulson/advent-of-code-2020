def find_tile(tiles, x, y)
  tiles.each do |t|
    return t if t.x == x && t.y == y
  end
  nil
end

class Tile

  attr_accessor :northeast, :northwest, :east, :west, :southeast, :southwest, :color, :x, :y

  def initialize(x,y,color="w")
    @x=x
    @y=y
    @color = color
    @northwest = nil
    @northeast = nil
    @east = nil
    @west = nil
    @southeast = nil
    @southwest = nil
  end

  def flip
    @color = @color == "w" ? "b" : "w"
  end

  def to_s
    puts "My Color: #{@color}"
    puts "West: #{@west&.color}"
    puts "East: #{@east&.color}"
    puts "SouthWest: #{@southwest&.color}"
    puts "SouthEast: #{@southeast&.color}"
    puts "NorthWest: #{@northwest&.color}"
    puts "NorthEast: #{@northeast&.color}"
  end

  def adjacent_black(tiles)
    [tiles[[x+2, y]]&.color,
    tiles[[x-2, y]]&.color,
    tiles[[x+1, y+1]]&.color,
    tiles[[x-1, y-1]]&.color,
    tiles[[x-1, y+1]]&.color,
    tiles[[x+1, y-1]]&.color].count("b")
  end

  def fill_adjacent(tiles)
    o = []
    unless @west
      @west = find_tile(tiles, x-2, y)
      unless @west
        @west ||= Tile.new(x-2, y)
        o << @west
        @west.east = self
      end
    end
    unless @east
      @east = find_tile(tiles, x+2, y)
      unless @east
        @east ||= Tile.new(x+2, y)
        o << @east
        @east.west = self
      end
    end
    unless @southwest
      @southwest = find_tile(tiles, x-1, y+1)
      unless @southwest
        @southwest ||= Tile.new(x-1, y+1)
        o << @southwest
        @southwest.northeast = self
      end
    end
    unless @southeast
      @southeast = find_tile(tiles, x+1, y+1)
      unless @southeast
        @southeast ||= Tile.new(x+1, y+1)
        o << @southeast
        @southeast.northwest = self
      end
    end
    unless @northwest
      @northwest = find_tile(tiles, x-1, y-1)
      unless @northwest
        @northwest ||= Tile.new(x-1, y-1)
        o << @northwest
        @northwest.southeast = self
      end
    end
    unless @northeast
      @northeast = find_tile(tiles, x+1, y-1)
      unless @northeast
        @northeast ||= Tile.new(x+1, y-1)
        o << @northeast
        @northeast.southwest = self
      end
    end
    o
  end

  def connect_adjacent(tiles)
    @west = find_tile(tiles, @x-2, @y) unless @west
    @west.east = self if @west
    @east = find_tile(tiles, @x+2, @y) unless @east
    @east.west = self if @east
    @southwest = find_tile(tiles, @x-1, @y+1) unless @southwest
    @southwest.northeast = self if @southwest
    @southeast = find_tile(tiles, @x+1, @y+1) unless @southeast
    @southeast.northwest = self if @southeast
    @northwest = find_tile(tiles, @x-1, @y-1) unless @northwest
    @northwest.southeast = self if @northwest
    @northeast = find_tile(tiles, @x+1, @y-1) unless @northeast
    @northeast.southwest = self if @northeast
  end
end

lines = File.readlines(ARGV[0]).map(&:chomp)

tiles = []
tiles[0] = Tile.new(0,0)
lines.each do |line|
  current = tiles[0]
  index = 0
  cs = line.chars
  last_c = nil
  while index < cs.length
    case cs[index]
    when "n"
      last_c = "n"
    when "s"
      last_c = "s"
    when "e"
      if last_c == "s"
        unless current.southeast = find_tile(tiles, current.x+1, current.y+1)
          tiles << Tile.new(current.x+1,current.y+1)
          current.southeast = tiles.last
          tiles.last.northwest = current
        end
        current = current.southeast
      elsif last_c == "n"
        unless current.northeast = find_tile(tiles, current.x+1, current.y-1)
          tiles << Tile.new(current.x+1,current.y-1)
          current.northeast = tiles.last
          tiles.last.northwest = current
        end
        current = current.northeast
      else
        unless current.east = find_tile(tiles, current.x+2, current.y)
          tiles << Tile.new(current.x+2, current.y)
          current.east = tiles.last
          tiles.last.west = current
        end
        current = current.east
      end
      last_c = nil
    when "w"
      if last_c == "s"
        unless current.southwest = find_tile(tiles, current.x-1, current.y+1)
          tiles << Tile.new(current.x-1,current.y+1)
          current.southwest = tiles.last
          tiles.last.northeast = current
        end
        current = current.southwest
      elsif last_c == "n"
        unless current.northwest = find_tile(tiles, current.x-1, current.y-1)
          tiles << Tile.new(current.x-1,current.y-1)
          current.northwest = tiles.last
          tiles.last.northeast = current
        end
        current = current.northwest
      else
        unless current.west = find_tile(tiles, current.x-2, current.y)
          tiles << Tile.new(current.x-2,current.y)
          current.west = tiles.last
          tiles.last.east = current
        end
        current = current.west
      end
      last_c = nil
    end
    index += 1
  end
  current.flip
end

puts tiles.map{|t| t.color == "b" ? 1 : 0}.sum

dict_tiles = {}

tiles.each do |t|
  dict_tiles[[t.x, t.y]] = t
end

tiles = dict_tiles

-150.upto(150) do |x|
  -150.upto(150) do |y|
    if (x.odd? && y.odd?) || (x.even? && y.even?)
      tiles[[x,y]] ||= Tile.new(x,y)
    end
  end
end

1.upto(100) do |a|
  new_tiles = {}
  tiles.each do |pos,t|
    b = t.adjacent_black(tiles)
    if t.color == "b"
      if b == 0 || b > 2
        new_tiles[[t.x,t.y]]=Tile.new(t.x, t.y, "w")
      else
        new_tiles[[t.x,t.y]]=Tile.new(t.x, t.y, "b")
      end
    else
      if b == 2
        new_tiles[[t.x,t.y]]=Tile.new(t.x, t.y, "b")
      else
        new_tiles[[t.x,t.y]]=Tile.new(t.x, t.y, "w")
      end
    end
  end
  tiles = new_tiles
end

puts tiles.map{|p,t| t.color == "b" ? 1 : 0}.sum