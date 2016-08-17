n,k = gets.strip.split(' ')
n = n.to_i
k = k.to_i
list = gets.strip.split.map(&:to_i)

remain = list.map {|a| {number: a, remainder: a % k} }.group_by {|x| x[:remainder]}

# group numbers with same remainder
count = 0

if k > 1
  (1...(k+1)/2).each do |i|
    a = i
    b = k - i
    # puts i
    # puts remain[b]
    # puts
    # puts remain[a]
    # puts '----'
    ac = remain[a] && remain[a].count
    bc = remain[b] && remain[b].count
    if ac && bc
      count += [ac, bc].max
    elsif ac
      count += ac
    elsif bc
      count += bc
    end
  end
end

count += 1 if remain[0]
count += 1 if k % 2 == 0 && remain[k/2]

puts count
