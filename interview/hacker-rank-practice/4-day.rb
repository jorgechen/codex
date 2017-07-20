cloud_count = gets.strip.to_i
clouds = gets.strip.split.map {|a| a == '1'}

i = 0
jumps = 0
while i < clouds.length - 1
  i += clouds[i + 2] ? 1 : 2
  jumps += 1
end
puts jumps

# Using breadth-first, bad performance

# require "set"
#
# def find_path(clouds)
#   visited = Set.new
#   list = [[0]]
#
#   results = []
#
#   until list.empty?
#     path = list.shift
#     start = path.last
#
#     [start + 1, start + 2].each do |i|
#       if i == clouds.length - 1
#         results.push(path.count) # we just need the number of jumps, excluding 0
#         # results.push(path + [i])
#         next
#       end
#
#       next if visited.include?(i)
#
#       visited << start
#
#       if !clouds[i] # if thunder cloud, we cannot jump
#         list.push(path + [i])
#       end
#     end
#   end
#
#   return results
# end
#
# choices = find_path(clouds)
#
# puts choices.min
