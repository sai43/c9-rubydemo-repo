
# #+TITLE: Implicit Splat
# #+SETUPFILE: ../defaults.org

# In the last episode we were splatting out values into variables, and
# then slurping them back up into arrays. As it turns out, in some
# cases we don't even need to use the splat operator to do this. 

# Let's use a four-element array as an example again. When we put it on
# the right side of an assignment, prefixed it with a star and put a
# list of variable names on the left side of the equals, the result is
# that individual elements of the array are assigned to the variables,
# one by one.

a = [:first, :second, :third, :fourth]
x, y, z = *a
x                               # => :first
y                               # => :second
z                               # => :third

# If we remove the splat operator, we get the exact same result.

a = [:first, :second, :third, :fourth]
x, y, z = a
x                               # => :first
y                               # => :second
z                               # => :third

# So why would we use the explicit operator in the first place? Well,
# for one thing, this only works when the array is alone on the
# right-hand side of the assignment. If it is listed along with some
# individual values, the array will be assigned as a whole rather than
# broken down into its component elements.

a = [:first, :second, :third, :fourth]
x, y, z = :before, a
x                               # => :before
y                               # => [:first, :second, :third, :fourth]
z                               # => nil

# If we want to the array elements to be broken out individually in
# this case, we need to supply an explicit splat.

a = [:first, :second, :third, :fourth]
x, y, z = :before, *a
x                               # => :before
y                               # => :first
z                               # => :second

# Another reason is that the implicit splat only works on a very
# restricted set of object types. For instance, a Ruby =Set= is similar
# to an array, and can be converted to one using =#to_a=. But when we
# substitute a =Set= for our array, the implicit splatting no longer
# workd. We have to be explicit to get the =Set= to be exploded into
# its elements.

require 'set'
a = [:first, :second, :third, :fourth]
s = Set.new(a)
# => #<Set: {:first, :second, :third, :fourth}>
s.to_a                          # => [:first, :second, :third, :fourth]
x, y, z = s
x                               # => #<Set: {:first, :second, :third, :fourth}>
y                               # => nil
z                               # => nil
x, y, z = *s
x                               # => :first
y                               # => :second
z                               # => :third

# An explicit splat could be said to be more "duck-type-safe" than an
# implicit one. If we write code with explicit splats on the right side
# of an assignment, it will work so long as the input object is
# convertible to an Array. Whereas if we rely on implicit splatting, the
# input must be an actual Array or something very close to one. We'll
# get into what it means to be "very close" to an Array in a future
# episode.

# Implicit splatting can also occur on the left side of an
# assignment. Let's look at the case of a simple multiple assignment,
# where a list of variables is matched up with an equal number of values
# on the right side of the equals. As we've seen before, the arguments
# on the right side of an assignment are matched up with names on
# the left side, one by one.

x, y, z = :first, :second, :third
x                               # => :first
y                               # => :second
z                               # => :third

# If we remove a variable name on the left side, the corresponding
# value on the right is simply ignored.

x, y = :first, :second, :third
x                               # => :first
y                               # => :second

# *Until* we pare the variable list down to just a single
# name. Suddenly, it slurps up *all* of the values into a new array.

x = :first, :second, :third
x                               # => [:first, :second, :third]

# Just as a single array on the right side of a multiple assignment was
# implicitly expanded out into its constituent elements, a single
# variable name on the left side causes Ruby to implicitly collapse the
# values into an array, even without prefixing the variable name with an
# asterisk. There is some sense to this; most of the time when we put a
# single variable on the left and a list of values on the right, what we
# probably intend to say is "put all of these values into this
# variable".

# This all may seem very academic, but there is at least one context in
# which understanding this implicit splatting behavior is can lead to
# fewer surprises. Consider the =Hash#each= method. For each key and
# value in the Hash, =#each= yields two block arguments: the key and
# the value.

h = { :orange => :juice,
      :apple  => :cider,
      :lemon  => :lemonade }

h.each do |key, value|
  puts "#{key}: #{value}"
end
# >> orange: juice
# >> apple: cider
# >> lemon: lemonade

# The question is, what happens when we provide a block with just one
# parameter? We might expect to get just the key. But what actually
# happens is a little different. The single argument is filled in with
# a two-element array containing both the of key and value.

h = { :orange => :juice,
      :apple  => :cider,
      :lemon  => :lemonade }

h.each do |arg|
  puts arg.inspect
end

# >> [:orange, :juice]
# >> [:apple, :cider]
# >> [:lemon, :lemonade]

# This can catch you by surprise if you're expecting just the key. You
# may be even more surprised when you try to /explicitly/ apply a splat
# to the single argument, and instead of getting the same pair of
# elements, you get a doubly-nested array.

h = { :orange => :juice,
      :apple  => :cider,
      :lemon  => :lemonade }

h.each do |*pair|
  puts pair.inspect
end

# >> [[:orange, :juice]]
# >> [[:apple, :cider]]
# >> [[:lemon, :lemonade]]

# To understand this behavior, we need to think of it in terms of
# assignment. On the left side of the assignment are the block
# parameters. On the right side are the values that the Hash is yielding
# to the block. When there are more than one variables on the left,
# Ruby implicitly splats the array on the right.

# do |key, value| ...  yield([:apple, :cider])
      key, value   =         [:apple, :cider]

key                             # => :apple
value                           # => :cider

# But when there is just one variable on the left, it receives the
# whole array as its value.

# do |pair| ...  yield([:apple, :cider])
      pair   =         [:apple, :cider]

pair                            # => [:apple, :cider]

# Where this comparison diverges is when we explicitly splat the left
# side. In assignment, this behaves the same as without the splat. But
# in the block argument list, it causes the pair to be wrapped in a
# second array.

# do |*pair| ...  yield([:apple, :cider])
      *pair   =         [:apple, :cider]

pair                            # => [:apple, :cider]

# We can reproduce this behavior without any library code using a simple
# method that just yields a single array. Here again, the resulting
# array is doubled up.

def yield_pair
  yield([:foo, :bar])
end

yield_pair do |*pair|
  puts pair.inspect
end
# >> [[:foo, :bar]]

# To force a similar doubling-up of the splatted array in a local
# variable assignment, we have to add a new variable before the
# splatted variable on the left, and a throwaway value for that new
# variable to take on the right. In this case the splat says "bundle
# all remaining arguments into a new array", and the remaining
# arguments happen to consist of just one array, which becomes the sole
# element of the new array.

# do |*pair| ... yield([:apple, :cider])
_,    *pair   = :_,    [:apple, :cider]

pair                            # => [[:apple, :cider]]
