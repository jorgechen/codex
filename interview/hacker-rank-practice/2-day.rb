n = gets.strip.to_i # number of sticks
lengths = gets.split(' ').map(&:to_i)

while lengths.count > 0 do
  puts lengths.count
  shortest = lengths.min
  lengths = lengths.map {|l| l - shortest}.select {|l| l > 0}
end
