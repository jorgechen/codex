def find_max_profit(a)

  length = a.length
  if length < 2
    raise 'Not enough data. At least 2 prices needed. '
  end

  
  i = 1
  min = a[0]
  profit = a[1] - a[0]

  while i < length do

    next if i == 0

    if (a[i] - min > profit)
      profit = a[i] - min
    end
    
    min = a[i] if a[i] < min

    i += 1
  end

  profit
end


n = [12, 16, 10, 8, 3, 19, 14, 5, 11, 1, 6, 2, 9, 17, 20, 4, 18, 13, 15, 7]
# n = [45, 34, 2, 0]
puts n.inspect
puts
puts find_max_profit(n)
