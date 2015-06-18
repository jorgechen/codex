require 'net/https'
require 'json'
require 'rubygems'

class Escape

   # Download via HTTP
   def self.download( link )
      uri = URI( link )

      http = Net::HTTP.new( uri.host, uri.port )
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_PEER

      request = Net::HTTP::Get.new( uri.request_uri )

      response = http.request(request)
      response.body
   end


   # Download JSON via HTTP
   def self.download_json( link )
      data = download(link)
      JSON.parse(data)
   end


   # Read JSON from file
   def self.read_json( file_path )
      JSON.load( IO.read(file_path) )
   end



   # @return true if we exploded at the current node
   def self.is_dead?(node, blast, asteroids)
      t = node[:t]
      p = node[:p]

      dead = false

      # If our dumb-asses reversed into the planet
      if p < 0
         dead = true
      end

      # If blast hit us
      if t / blast > p
         dead = true
      end

      # If asteroid collided with us
      if p != 0
         asteroid = asteroids[p - 1] # NOTE: ignore p=0, first asteroid is p=1
         cycle = asteroid[ 't_per_asteroid_cycle' ]
         offset = asteroid[ 'offset' ]
         current_offset = (offset + t) % cycle
         if 0 == current_offset
            dead = true
         end
      end

      dead
   end

   # Key for a given (time, position, velocity)
   @PP = 100000
   @TT = 100000
   def self.hash_code(node)
      node[:p] + @PP * node[:t] + @TT * @PP * node[:v]
   end





   # Depth-first search to survive the escape
   # @return an array of the acceleration values needed
   def self.find_escape(data, find_shortest = false)

      asteroids = data['asteroids'] # { a1, a2, ... }
      blast = data['t_per_blast_move'] # int
      safe_distance = asteroids.length


      resultPath = nil

      root = {t: 0, p: 0, v: 0, a: []}

      # Visited nodes
      visited = {}

      shortest_time = nil # TODO set to nil

      # First in is first to visit
      stack = [root]

      # NOTE: p=0 is the planet itself
      #       p=1 is the first asteroid
      #       p=asteroids.length is the last asteroid

      while not stack.empty?

         # Pop a node out
         current = stack.shift

         # Check visited or not
         key = hash_code(current)
         if visited[key]

            # TODO remove
            v = visited[key]
            if v[:t] != current[:t] or v[:p] != current[:p] or v[:v] != current[:v]
               raise "hash_code FAILED #{v} #{current}"
            end

         elsif find_shortest and not shortest_time.nil? and current[:t] >= shortest_time
            # puts "Skipped this path #{current} because it is not shortest"
            visited[key] = current

         else
            visited[key] = current
            p = current[:p]

            if p > safe_distance
               # We have escaped!

               if shortest_time.nil? or shortest_time > current[:t]
                  shortest_time = current[:t]
                  resultPath = current[:a]
               end

               # Stop the search if we just need any solution
               break unless find_shortest

            elsif is_dead?(current, blast, asteroids)
               # We would die here, it's a dead end

            else
               # Keep going
               t = current[:t]
               v = current[:v]
               p = current[:p]
               a = current[:a]

               t = t + 1

               # a = -1
               # This is an unfavorable path, so traverse it 3rd
               vSlow = v - 1
               pSlow = p + vSlow
               stack.unshift( {t: t, p: pSlow, v: vSlow, a: a + [-1]} )


               # a = 0
               pCruise = p + v
               stack.unshift( {t: t, p: pCruise, v: v, a: a + [0]} )

               # a = +1
               # This is a priority, so traverse it first
               vThrottle = v + 1
               pThrottle = p + vThrottle
               stack.unshift( {t: t, p: pThrottle, v: vThrottle, a: a + [1]} )


            end
         end

      end


      puts "Visited #{visited.length} nodes"

      resultPath
   end


   # Get a smaller subset of asteroids
   def self.benchmark_helper data, length
      input = {
         't_per_blast_move' => data['t_per_blast_move'],
         'asteroids' => data['asteroids'][0..length]
      }
   end


   # Measure how long these things take
   def self.benchmark
      sample = download_json('https://gist.githubusercontent.com/anonymous/0872aafe0bb179d81bed/raw/11675dcbd240af3362e8e4d63be265cc7b774ab6/chart.json')
      input = Escape.read_json( 'v3_chart.json' )

      require 'benchmark'
      Benchmark.bm(7) do |x|
         x.report("Sample:") { Escape.find_escape(sample) }

         length = 100
         x.report("Input #{length}:") { Escape.find_escape(benchmark_helper(input, length)) }

         length = 300
         x.report("Input #{length}:") { Escape.find_escape(benchmark_helper(input, length)) }

         length = 500
         x.report("Input #{length}:") { Escape.find_escape(benchmark_helper(input, length)) }

         length = 700
         x.report("Input #{length}:") { Escape.find_escape(benchmark_helper(input, length)) }

         length = 1000
         x.report("Input #{length}:") { Escape.find_escape(benchmark_helper(input, length)) }

      end
   end

end




########################################################################
########################################################################


## Test solution speed
# Escape.benchmark


## Actual solution
input = Escape.read_json( 'v3_chart.json' )
puts "Length of escape: #{input['asteroids'].length}"

start = Time.now

# Find escape route

find_shortest = false
if not ARGV.empty? and ARGV.length == 1 and ARGV[0] == 'shortest'
   puts "Finding shortest course..."
   find_shortest = true
end
result = Escape.find_escape(input, find_shortest)

elapsed = Time.now - start
puts "#{elapsed} seconds taken."

puts "Result: #{result}"

# Write results to file
file = 'course.json'
File.write(file, result)
puts "Results saved to #{file}"

