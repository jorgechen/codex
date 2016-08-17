#https://www.hackerrank.com/contests/kc4/challenges/game-of-life-1

# The original problem's test cases seem to be incorrect ...

# 1
# 4 4
# 0 0 0 0
# 0 0 0 0
# 0 0 1 0
# 0 0 0 0
#
# 1
# 4 4
# 0 0 0 0
# 0 1 0 0
# 0 1 1 0
# 0 0 0 0

def in_bound?(i, j, rows, cols)
  i >= 0 && j >= 0 && i < rows && j < cols
end

case_count = gets.strip.to_i
case_count.times.each do |case_index|
  dimensions = gets.strip.split(' ')
  row_count = dimensions.first.to_i
  col_count = dimensions.last.to_i

  grid = []
  row_count.times.each do |row_i|
    row = gets.strip.split(' ').map(&:to_i)
    grid.push(row.map {|i| i == 1})
  end

  lives = false

  puts '_____'
  row_count.times.each do |i|
    col_count.times.each do |j|
      alive = grid[i][j]

      neighbors = 0
      neighbors += 1 if in_bound?(i - 1, j - 1, row_count, col_count) && grid[i - 1][j - 1]
      neighbors += 1 if in_bound?(i - 1, j, row_count, col_count) && grid[i - 1][j]
      neighbors += 1 if in_bound?(i - 1, j + 1, row_count, col_count) && grid[i - 1][j + 1]
      neighbors += 1 if in_bound?(i, j + 1, row_count, col_count) && grid[i][j + 1]
      neighbors += 1 if in_bound?(i + 1, j + 1, row_count, col_count) && grid[i + 1][j + 1]
      neighbors += 1 if in_bound?(i + 1, j, row_count, col_count) && grid[i + 1][j]
      neighbors += 1 if in_bound?(i + 1, j - 1, row_count, col_count) && grid[i + 1][j - 1]
      neighbors += 1 if in_bound?(i, j - 1, row_count, col_count) && grid[i][j - 1]

      if (alive && (2 == neighbors || neighbors == 3)) || (!alive && neighbors == 3)
        lives = true
      end

      if alive
        if neighbors < 2
          print "0 "
        elsif neighbors < 4
          print "1 "
        else
          print "0 "
        end
      elsif neighbors == 3
        print "1 "
      else
        print "0 "
      end
    end
    puts
  end

  puts "Case ##{case_index + 1}: #{lives ? 'alive' : 'dead'}"
end
