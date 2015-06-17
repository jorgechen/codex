require 'net/https'
require 'json'
require 'rubygems'

# Download via HTTP
def download( link )
   uri = URI( link )

   http = Net::HTTP.new( uri.host, uri.port )
   http.use_ssl = true
   http.verify_mode = OpenSSL::SSL::VERIFY_PEER

   request = Net::HTTP::Get.new( uri.request_uri )

   response = http.request(request)
   response.body
end


# Download JSON via HTTP
def download_json( link )
   data = download(link)
   JSON.parse(data)
end


# Read JSON from file
def read_json( file_path )
   JSON.load( IO.read(file_path) )
end



# @return true if we exploded at the current node
def is_dead?(node, blast, asteroids)
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
   asteroid = asteroids[p - 1] # NOTE that p=1 is first asteroid
   cycle = asteroid[ 't_per_asteroid_cycle' ]
   offset = asteroid[ 'offset' ]
   current_offset = (offset + t) % cycle
   if 0 == current_offset
      dead = true
   end

   dead
end

# input = read_json( 'v3_chart.json' )
input = download_json('https://gist.githubusercontent.com/anonymous/0872aafe0bb179d81bed/raw/11675dcbd240af3362e8e4d63be265cc7b774ab6/chart.json')
# input = read_json 'v3_chart.json'
# xputs input

puts input['asteroids'].length


# The idea is a depth-first search
# With priority given to the +1 path
def find_escape(data)

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
         puts "ESCAPE! #{current}"

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


# # Key for a given (time, position, velocity)
# @PP = 100000
# @TT = 100000
# def hash_code(node)
#    node[:p] + @PP * node[:t] + @TT * @PP * node[:v]
# end


find_escape(input)


