
# In place, i.e. no additional memory
def reverse_words(line)
  reverse_characters(line)
  reverse_each_word(line)
end


# This is a simpler step
def reverse_characters(line, left = 0, right = line.length - 1)
  # puts "reversing #{left}-#{right} " + line[left...right]
  i = left
  j = right
  while i < j
    # puts "swapping #{line[i]},#{line[j]}"
    line[i], line[j] = line[j], line[i]
    i += 1
    j -= 1
  end
end

def reverse_each_word(line)
  left = 0
  for right in 0..line.length
    if line[right] == ' ' or right == line.length
      reverse_characters line, left, right - 1
      left = right + 1
    end
  end
end


input = [
  'abc def rst',
  'one two three four five six seven'
]

input.each do |i|
  message = i + '->'
  reverse_words i
  message += i
  puts message
end


