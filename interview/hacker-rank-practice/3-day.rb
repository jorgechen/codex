n,k = gets.strip.split(' ')
n = n.to_i
k = k.to_i
list = gets.strip.split.map(&:to_i)

ineligible = []

list[0...-1].each_with_index do |a, i|
  list[i+1..-1].each do |b|
    if (a + b) % k == 0
      puts "#{a} + #{b}"
      ineligible.push(a, b)
    end
  end
end

eligible = list - ineligible

puts eligible.count
