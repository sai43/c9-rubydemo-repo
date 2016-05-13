a1 = [:first, :second, :third, :fourth]
a2 = [:before, a1, :after]
a2
# => [:before, [:first, :second, :third, :fourth], :after]

a1 = [:first, :second, :third, :fourth]
a2 = [:before, a1, :after] 
a2.flatten
# => [:before, :first, :second, :third, :fourth, :after]
a2 = [:before, *a1, :after]
# => [:before, :first, :second, :third, :fourth, :after]

x, y, z = 1, 2, 3
x                               # => 1
y                               # => 2
z                               # => 3

a1 = [:first, :second, :third, :fourth]
x, y, z = *a1
x                               # => :first
y                               # => :second
z                               # => :third


a1 = [:first, :second, :third, :fourth]
x, y, z = :before, *a1
x                               # => :before
y                               # => :first
z                               # => :second



a1 = [:first, :second, :third, :fourth]
*x, y, z = *a1
x                               # => [:first, :second]
y                               # => :third
z                               # => :fourth
x, *y, z = *a1
x                               # => :first
y                               # => [:second, :third]
z                               # => :fourth
x, y, *z = *a1
x                               # => :first
y                               # => :second
z                               # => [:third, :fourth]

a1 = [:first, :second, :third, :fourth]
first, *rest = *a1

first                           # => :first
rest                            # => [:second, :third, :fourth]

def sum3(x, y, z)
  x + y + z
end

triangle = [90, 30, 60]
sum3(*triangle)                 # => 180


def greet(greeting, *names)
  names.each do |name|
    puts "#{greeting}, #{name}"
  end
end

greet("Good morning", "Grumpy", "Sneezy", "Dopey")
# >> Good morning, Grumpy
# >> Good morning, Sneezy
# >> Good morning, Dopey


def random_draw(num_times, num_draws)
  num_times.times do
    draws = num_draws.times.map { rand(10) }
    yield(*draws)
  end
end

random_draw(5, 3) do |first, second, third|
  puts "#{first} #{second} #{third}"
end
# >> 9 5 3
# >> 3 8 1
# >> 4 7 6
# >> 2 1 3
# >> 8 3 3


def random_draw(num_times, num_draws)
  num_times.times do
    draws = num_draws.times.map { rand(10) }
    yield(*draws)
  end
end

random_draw(5, 3) do |first, *rest|
  puts "#{first}; #{rest.inspect}"
end
# >> 7; [7, 0]
# >> 6; [6, 9]
# >> 6; [6, 2]
# >> 2; [2, 3]
# >> 3; [2, 2]

