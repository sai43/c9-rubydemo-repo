
# #fetch beyond Hash

# First of all, it's worth noting that while up till now I've
# demonstrated it in the context of =Hash= objects, =#fetch= isn't
# limited to Hashes. It's also available on =Arrays=, where it behaves
# very similar to the Hash version, except that when the key is missing
# and no default block is supplied, it raises an =IndexError= instead of
# a =KeyError=.

a = [:x, :y, :z]
a.fetch(3)
# ~> -:2:in `fetch': index 3 outside of array bounds: -3...3 (IndexError)
# ~>    from -:2:in `<main>'

# You can also find =#fetch= the =ENV= pseudo-hash. I find this very
# useful for optional configuration values, for example enabling a port
# number to be customized via environment variable while still providing
# a default value.

port = ENV.fetch('PORT'){ 8080 }.to_i
port # => 8080

# Defaults for nested hashes

# Sometimes, you may want to get optional values out of a nested
# hash. Not only do you not know if the values will be present, but you
# don't even know if the nested sub-trees will be there. For instance,
# here's some configuration data:

config1 = {
  database: {
    type: 'mysql',
    host: 'localhost'
  }
}

config2 = {}                    # empty!

# I like to handle data like this by chaining fetch statements together,
# with empty hashes as the default values for missing subtrees:

config2.fetch(:database){{}}.fetch(:type){'sqlite'}
# => "sqlite"

# Generalized default blocks

# One thing I haven't yet shown about =#fetch= is that it yields the
# missing key that was passed in. Here's some code that demonstrates
# what I mean:

{}.fetch(:foo) do |key|
  puts "Missing key: #{key}"
end
# >> Missing key: foo

# One scenario where this could be useful is if we have a lot of calls
# to fetch which should all handle a missing key the same way. We can
# define the default block as a lambda taking one argument, and pass the
# lambda to each call to =fetch=. 

# This code prompts the user for missing values.

default = ->(key) do
  puts "#{key} not found, please enter it: "
  gets
end

h = {}
name = h.fetch(:name, &default)
email = h.fetch(:email, &default)

# Two-argument form of #fetch

# If you're already familiar with the =#fetch= method you may be
# wondering why I haven't used the two-argument form in any of these
# videos. For those who aren't familiar, instead of passing a block to
# =#fetch= for the default value, you can pass a second argument
# instead.

{}.fetch(:threads, 4)              # => 4

# This avoids the slight overhead of executing a block, at the cost of
# evaluating the default value whether it is needed or not.

# Personally, I never use the two-argument form. I prefer to always use
# the block form. Here's why: let's say we're writing a program and we
# use the two-argument form of fetch in order to avoid that block
# overhead. Because the default value is used in more than one place, we
# extract it into a method.

def default
  42 # the ultimate answer
end

answers = {}
answers.fetch("How many roads must a man walk down?", default)
# => 42

# Later on, we decide to change the implementation of =#default= to a
# much more expensive computation. Maybe one that has to communicate
# with an remote service before returning.

def default
  # ...some expensive computation
end

answers = {}
answers.fetch("How many roads must a man walk down?", default)
