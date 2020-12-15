lines = File.readlines(ARGV[0]).map(&:chomp)[0].split(',').map &:to_i

nums = lines

index = nums.length
while nums.length < 2020
  last = nums[index - 1]
  if nums[0..index-2].include?(last)
    puts index if index % 100000 == 0
    nums << index - 1 - (nums.length-2 - nums[0..index-2].reverse.index(last))
  else
    nums << 0
  end
  index += 1
end


puts nums[2020-1]

mapnums = {}

newnums = lines
newnums.each_with_index do |n, i|
  mapnums[n] ||= []
  mapnums[n] << i
end

index = newnums.length
while index < 30000000
  last = newnums[index-1]
  curr = 0
  if mapnums[last].count > 1
    curr = mapnums[last][-1] - mapnums[last][-2]
  end
  mapnums[curr] ||= []
  mapnums[curr] << index
  newnums << curr
  index += 1
end

puts newnums[30000000-1]

