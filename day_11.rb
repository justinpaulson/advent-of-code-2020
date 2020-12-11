viz = false

def adjacent_occupied(seats, i, j)
  count = 0
  count += 1 if i.positive? && seats[i-1][j] && seats[i-1][j] == "#"
  count += 1 if i < seats.length-1 && seats[i+1][j] && seats[i+1][j] == "#"
  count += 1 if j.positive? && seats[i][j-1] && seats[i][j-1] == "#"
  count += 1 if j < seats[i].length-1 && seats[i][j+1] && seats[i][j+1] == "#"
  count += 1 if i.positive? && j.positive? && seats[i-1][j-1] && seats[i-1][j-1] == "#"
  count += 1 if i < seats.length-1 && j < seats[i].length - 1 && seats[i+1][j+1] && seats[i+1][j+1] == "#"
  count += 1 if i < seats.length-1 && j.positive? && seats[i+1][j-1] && seats[i+1][j-1] == "#"
  count += 1 if i.positive? && j < seats[i].length-1 && seats[i-1][j+1] && seats[i-1][j+1] == "#"
  count
end

def visible_adjacent_occupied(seats, i, j)
  count = 0
  if i.positive?
    new_i = i - 1
    new_j = j
    new_i -= 1 while new_i.positive? && seats[new_i][j] == "."
    count += 1 if seats[new_i][j] == "#"
  end

  if i < seats.length-1
    new_i = i + 1
    new_j = j
    new_i += 1 while new_i < seats.length-1 && seats[new_i][j] == "."
    count += 1 if seats[new_i][j] == "#"
  end

  if j.positive?
    new_i = i
    new_j = j - 1
    new_j -= 1 while new_j.positive? && seats[i][new_j] == "."
    count += 1 if seats[i][new_j] == "#"
  end

  if j < seats[i].length-1
    new_i = i
    new_j = j + 1
    new_j += 1 while new_j < seats[i].length-1 && seats[i][new_j] == "."
    count += 1 if seats[i][new_j] == "#"
  end

  if i.positive? && j.positive?
    new_i = i - 1
    new_j = j - 1
    while new_i.positive? && new_j.positive? && seats[new_i][new_j] == "."
      new_i -= 1
      new_j -= 1
    end
    count += 1 if seats[new_i][new_j] == "#"
  end

  if i < seats.length-1 && j < seats[i].length - 1
    new_i = i + 1
    new_j = j + 1
    while new_i < seats.length-1 && new_j < seats[i].length - 1 && seats[new_i][new_j] == "."
      new_i += 1
      new_j += 1
    end
    count += 1 if seats[new_i][new_j] == "#"
  end

  if i < seats.length-1 && j.positive?
    new_i = i + 1
    new_j = j - 1
    while new_i < seats.length-1 && new_j.positive? && seats[new_i][new_j] == "."
      new_i += 1
      new_j -= 1
    end
    count += 1 if seats[new_i][new_j] == "#"
  end

  if i.positive? && j < seats[i].length-1
    new_i = i - 1
    new_j = j + 1
    while new_i.positive? && new_j < seats[i].length-1 && seats[new_i][new_j] == "."
      new_i -= 1
      new_j += 1
    end
    count += 1 if seats[new_i][new_j] == "#"
  end

  count
end

def count_occupied(seats)
  seats.map(&:join).join.count("#")
end

def print_grid(grid)
  system 'clear'
  0.upto(grid.length-1) do |x|
    puts grid[x].join
  end
end


seats = File.readlines(ARGV[0]).map(&:chomp).map(&:chars)
while true do
  new_seats = []
  0.upto(seats.size-1) do |i|
    new_seats[i] ||= []
    0.upto(seats[i].size-1) do |j|
      case seats[i][j]
      when "L"
        if adjacent_occupied(seats, i, j) == 0
          new_seats[i][j] ||= "#"
        else
          new_seats[i][j] ||= "L"
        end
      when "#"
        if adjacent_occupied(seats, i, j) >= 4
          new_seats[i][j] ||= "L"
        else
          new_seats[i][j] ||= "#"
        end
      else
        new_seats[i][j] ||= '.'
      end
    end
  end
  break if seats == new_seats
  seats = new_seats
  print_grid seats if viz
end

puts count_occupied(seats)

seats = File.readlines(ARGV[0]).map(&:chomp).map(&:chars)
while true do
  new_seats = []
  0.upto(seats.size-1) do |i|
    new_seats[i] ||= []
    0.upto(seats[i].size-1) do |j|
      case seats[i][j]
      when "L"
        if visible_adjacent_occupied(seats, i, j) == 0
          new_seats[i][j] ||= "#"
        else
          new_seats[i][j] ||= "L"
        end
      when "#"
        if visible_adjacent_occupied(seats, i, j) >= 5
          new_seats[i][j] ||= "L"
        else
          new_seats[i][j] ||= "#"
        end
      else
        new_seats[i][j] ||= '.'
      end
    end
  end
  break if seats == new_seats
  seats = new_seats
  if viz
    print_grid seats
    puts '=========================================='
    sleep 1
  end
end


puts count_occupied(seats)
