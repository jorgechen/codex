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


# @return offset at time
# If result is 0, then asteroid is in the way
def is_asteroid_blocking_at?( time, asteroid )
   offset = asteroid[ 'offset' ]
   cycle = asteroid[ 't_per_asteroid_cycle' ]

   (t * cycle) + offset
end


# @return if
def is_exploded?(time, position)

end

# input = read_json( 'v3_chart.json' )
# input = download_json('https://gist.githubusercontent.com/anonymous/0872aafe0bb179d81bed/raw/11675dcbd240af3362e8e4d63be265cc7b774ab6/chart.json')
input = read_json 'v3_chart.json'
# xputs input

puts input['asteroids'].length


# The idea is a depth-first search
# With priority given to the +1 path

def find_escape(asteroids, )

   root = {t: 0, p: 0, v: 0}

   # First in is first to visit
   stack = [root]

   while not stack.empty?
      current = stack.shift

      # Did we escape yet?
      # Is this a dead-end?
      # Search more

      if current.position >



   end
end

# Vertices are (time, position, velocity)
# Edge weight is the acceleration, -1, 0, or 1 for
# A node in this graph is
# (time, position)
nodes = {
   # {3 => 4},
   # {0 => 0}
}

# Key for a given (time, position, velocity)
def hash_code(t, p, v)
   PP = 100000
   TT = 100000
   VV = 1000

   PP * p +
end

