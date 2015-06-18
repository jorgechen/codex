# This simulates an escape course

class Simulator

   def initialize(field)
      @field = field
      @asteroids = field['asteroids']
      @blast = field['t_per_blast_move']
   end


   def coordinates(t, v, p)
      "t=#{t}, v=#{v}, p=#{p}"
   end


   def blasted?(t, v, p)
      p_blast_safe = t / @blast # minimum position that's safe from blast
      p < p_blast_safe
   end


   def collided?(t, v, p)
      # p = 0 is planet
      # p = 1 is first asteroid
      yes = false

      if p >= @asteroids.length
         # We've gone past the asteroids now

      elsif p > 0
         asteroid = @asteroids[p - 1]

         offset = asteroid['offset']
         cycle = asteroid['t_per_asteroid_cycle']

         if 0 == (offset + t) % cycle
            yes = true
         end
      end

      yes
   end


   def stupid?(t, v, p)
      p < 0
   end


   def simulate(course)
      t = 0
      v = 0
      p = 0

      index = 0

      course.each do |a|

         # Find next point
         t = t + 1
         v = v + a
         p = p + v

         if p > @asteroids.length
            puts "We are safe."
            break
         end

         if stupid?(t, v, p)
            puts "REVERSED INTO THE PLANET, STUPID: #{coordinates(t, v, p)}"
            break
         end

         if blasted?(t, v, p)
            puts "BLASTED: #{coordinates(t, v, p)}"
            break
         end

         if collided?(t, v, p)
            puts "COLLIDED: #{coordinates(t, v, p)}"
            break
         end


         index = index + 1
      end

      puts "Ended at #{coordinates(t, v, p)} index=#{index} #{course[0..index]}"

   end

end


# MAIN

require 'json'

chart_path = 'v3_chart.json'
file_path = 'course0.json'
if not ARGV.empty?
   file_path = ARGV.first

   if ARGV.length >= 2
      chart_path = ARGV[1]
   end
end

chart = JSON.load( IO.read(chart_path) )
course = JSON.load( IO.read(file_path) )

s = Simulator.new(chart)

s.simulate(course)
