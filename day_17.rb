lines = File.readlines(ARGV[0]).map(&:chomp).map(&:chars)

def neighbors3d(grid, x,y,z)
  t=0
  (x-1).upto(x+1) do |i|
    (y-1).upto(y+1) do |j|
      (z-1).upto(z+1) do |k|
        if !([i,j,k] == [x,y,z]) && grid[[i,j,k]] && grid[[i,j,k]] == '#'
          t+=1
        end
      end
    end
  end
  t
end

def neighbors4d(grid, x,y,z,w)
  t=0
  (x-1).upto(x+1) do |i|
    (y-1).upto(y+1) do |j|
      (z-1).upto(z+1) do |k|
        (w-1).upto(w+1) do |l|
          if !([i,j,k,l] == [x,y,z,w]) && grid[[i,j,k,l]] && grid[[i,j,k,l]] == '#'
            t+=1
          end
        end
      end
    end
  end
  t
end

grid = {}
lines.each_with_index do |line, y|
  line.each_with_index do |pixel, x|
    grid[[x,y,0]] = pixel
  end
end

cycle = 0
xr = [0,lines[0].length-1]
yr = [0,lines[0].length-1]
zr = [0,0]
wr = [0,0]
while cycle < 6
  new_grid = {}
  (xr[0]-1).upto(xr[1]+1) do |x|
    (yr[0]-1).upto(yr[1]+1) do |y|
      (zr[0]-1).upto(zr[1]+1) do |z|
        neigh = neighbors3d(grid, x, y, z)
        if grid[[x,y,z]] == '#'
          if neigh == 2 || neigh == 3
            new_grid[[x,y,z]] = '#'
          else
            new_grid[[x,y,z]] = '.'
          end
        else
          if neigh == 3
            new_grid[[x,y,z]] = '#'
          else
            new_grid[[x,y,z]] = '.'
          end
        end
      end
    end
  end
  grid = new_grid
  cycle+=1
  xr = [xr[0]-1,xr[1]+1]
  yr = [yr[0]-1,yr[1]+1]
  zr = [zr[0]-1,zr[1]+1]
end

puts grid.values.count('#')

grid = {}
lines.each_with_index do |line, y|
  line.each_with_index do |pixel, x|
    grid[[x,y,0,0]] = pixel
  end
end

cycle = 0
xr = [0,lines[0].length-1]
yr = [0,lines[0].length-1]
zr = [0,0]
wr = [0,0]
while cycle < 6
  new_grid = {}
  (xr[0]-1).upto(xr[1]+1) do |x|
    (yr[0]-1).upto(yr[1]+1) do |y|
      (zr[0]-1).upto(zr[1]+1) do |z|
        (wr[0]-1).upto(wr[1]+1) do |w|
          neigh = neighbors4d(grid, x, y, z, w)
          if grid[[x,y,z,w]] == '#'
            if neigh == 2 || neigh == 3
              new_grid[[x,y,z,w]] = '#'
            else
              new_grid[[x,y,z,w]] = '.'
            end
          else
            if neigh == 3
              new_grid[[x,y,z,w]] = '#'
            else
              new_grid[[x,y,z,w]] = '.'
            end
          end
        end
      end
    end
  end
  grid = new_grid
  cycle+=1
  xr = [xr[0]-1,xr[1]+1]
  yr = [yr[0]-1,yr[1]+1]
  zr = [zr[0]-1,zr[1]+1]
  wr = [wr[0]-1,wr[1]+1]
end

puts grid.values.count('#')