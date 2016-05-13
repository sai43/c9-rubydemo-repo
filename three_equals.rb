# You know the threequals operator? The one that acts as a "smart"
# matching operator in Ruby? It sure is handy. You can match regular
# expressions, ranges, even classes with it.

/\A\d+\z/ === "54321" # => true
(0..10) === 5         # => true
Numeric === 123       # => true

# You probably also know that the threequals is used under the hood by
# case statements.

case obj
when /\A\d+\z/ 
  puts "A numeric string"
when 0..10
  puts "A positive integer under 10"
when Numeric
  puts "A number"
end

# Here's something you might not have known: the =Proc= class aliases
# =#==== to the =#call= method. Let's see what this means. We define a
# lambda that will determine if a number is even. So if we call it on
# the number "2", for example, it returns =true=, and when we call it on
# "3" it returns =false=.

# There's nothing new here so far. But instead of sending the =#call=
# message, we can substitute the threequals operator, and get the exact
# same result!

even = ->(x){ (x % 2) == 0 }
even.call(2)                    # => true
even.call(3)                    # => false

even === 2                      # => true
even === 3                      # => false

# Since it implements the threequals, we can use this lambda as a
# predicate in a case statement.

case num
when even then puts "Even"
else puts "Odd"
end

# The implications of this are pretty big. They mean we can define
# arbitrary "matchers" for any kind of complex condition we can think
# of. As a more practical example, here's some code that uses a case
# statement to determine if an HTTP response was successful or not.

require 'net/http'

SUCCESS = ->(response) { (200..299) === response.code.to_i }
CLIENT_ERROR = ->(response) { (400..499) === response.code.to_i }

response = Net::HTTP.get_response(URI.parse("http://www.google.com"))
case response
when SUCCESS then puts "Success!"
when CLIENT_ERROR then puts "Client error."
else puts "Other"
end
# >> Success!
