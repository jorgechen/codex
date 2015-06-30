
# This is a simpler step
def reverse_characters(line)
  i = 0
  j = line.length - 1
  while i < j
    line[i], line[j] = line[j], line[i]
    i += 1
    j -= 1
  end
end



input = [
  'abc def rst',
  'one two three four five six seven'
]

input.each do |i|
  message = i + '->'
  reverse_characters i
  message += i
  puts message
end


