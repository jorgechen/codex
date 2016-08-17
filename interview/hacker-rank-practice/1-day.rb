#!/bin/ruby

t = gets.strip.to_i
for a0 in (0..t-1)

  # individual test case:
  n,k = gets.strip.split(' ')
  n = n.to_i # number of students
  k = k.to_i # threshold number of students for class to ensue
  a = gets.strip # array of each student's time
  a = a.split(' ').map(&:to_i)

  count = a.select {|time| time <= 0 }.count
  if count < k
    puts 'YES'
  else
    puts 'NO'
  end
end
