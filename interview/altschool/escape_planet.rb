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
      # puts "Wrecked at #{node} - FROM BEING DUMB"
      dead = true
   end

   # If blast hit us
   if t / blast > p
      # puts "Wrecked at #{node} - FROM BLAST"
      dead = true
   end

   # If asteroid collided with us
   if p != 0
      asteroid = asteroids[p - 1] # NOTE: ignore p=0, first asteroid is p=1
      cycle = asteroid[ 't_per_asteroid_cycle' ]
      offset = asteroid[ 'offset' ]
      current_offset = (offset + t) % cycle
      if 0 == current_offset
         # puts "Wrecked at #{node} - FROM ASTEROID"
         dead = true
      end
   end

   dead
end


# Depth-first search to survive the escape
# @return an array of the acceleration values needed
def self.find_escape(data)

   asteroids = data['asteroids'] # { a1, a2, ... }
   blast = data['t_per_blast_move'] # int
   safe_distance = asteroids.length


   root = {t: 0, p: 0, v: 0}

   # First in is first to visit
   stack = [root]

   # NOTE: p=0 is the planet itself
   #       p=1 is the first asteroid
   #       p=asteroids.length is the last asteroid

   while not stack.empty?

      current = stack.shift
      p = current[:p]

      if p > safe_distance
         # We have escaped!
         # puts "ESCAPE! #{current}"

         # Stop the search
         stack.clear

      elsif is_dead?(current, blast, asteroids)
         # We would die here

      else
         # Keep going
         t = current[:t]
         v = current[:v]
         p = current[:p]

         t = t + 1

         # a = 0
         pCruise = p + v
         stack.unshift( {t: t, p: pCruise, v: v} )

         # a = +1
         # This is a priority path, so put it on top
         vThrottle = v + 1
         pThrottle = p + vThrottle
         stack.unshift( {t: t, p: pThrottle, v: vThrottle} )


         # a = -1
         # This is an unfavorable path, so put it at the bottom
         # OPTIMIZE: put it in the middle, or the 3rd?
         vSlow = v - 1
         pSlow = p + vSlow
         stack.push( {t: t, p: pSlow, v: vSlow} )
      end

   end
end


def self.benchmark_helper data, length

   input = {
      't_per_blast_move' => data['t_per_blast_move'],
      'asteroids' => data['asteroids'][0..length]
   }

end

def self.benchmark
   sample = download_json('https://gist.githubusercontent.com/anonymous/0872aafe0bb179d81bed/raw/11675dcbd240af3362e8e4d63be265cc7b774ab6/chart.json')
   input = Escape.read_json( 'v3_chart.json' )

   require 'benchmark'
   Benchmark.bm(7) do |x|
      x.report("Sample:") { Escape.find_escape(sample) }

      length = 5
      x.report("Input #{length}:") { Escape.find_escape(benchmark_helper(input, length)) }

      length = 50
      x.report("Input #{length}:") { Escape.find_escape(benchmark_helper(input, length)) }

      length = 100
      x.report("Input #{length}:") { Escape.find_escape(benchmark_helper(input, length)) }


   end
end

end
# # Key for a given (time, position, velocity)
# @PP = 100000
# @TT = 100000
# def hash_code(node)
#    node[:p] + @PP * node[:t] + @TT * @PP * node[:v]
# end



########################################################################
########################################################################

# Actual data
input = Escape.read_json( 'v3_chart.json' )

# Test solution speed
# Escape.benchmark

Escape.find_escape(input)



