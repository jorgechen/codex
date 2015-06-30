
def condense_meeting_times(meetings)
  result = [] # [1, 4] means range of 1-4

  meetings.each do |m|
    condensed = false

    result.each do |r|

      if (m[0] >= r[0] and m[0] <= r[1])
        condensed = true
        if m[1] > r[1]
          r[1] = m[1]
        end
        break
      elsif (m[1] >= r[0] and m[1] <= r[1])
        condensed = true
        if m[0] < r[0]
          r[0] = m[0]
        end
        break
      end

    end

    if not condensed
      result.push(m)
    end

  end

  result
end


input =   [[0, 1], [3, 5], [4, 8], [10, 12], [9, 10]]


output = condense_meeting_times(input)

puts output.inspect

