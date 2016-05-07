#definition of blocks is "A section of code which is grouped together." Of course, 
# I'm guessing this doesn't help you much.
#A simpler way to describe blocks is
#“A block is code that you can store in a variable like any other object and run on demand.”

puts 5+6

a = 5
b = 6
puts a + b

addition = lambda {|a, b| return a + b }
#addition = proc {|a, b| return a + b }
puts addition.call(5, 6)

empty_block = lambda { }
puts empty_block.object_id
puts empty_block.class
puts empty_block.class.superclass


class Calculator
  def add(a, b)
    return a + b
  end
end

puts Calculator.new.add(5, 6)



class Calculator
  def add(a, b)
    return a + b
  end
end

addition_method = Calculator.new.method("add")
addition =  addition_method.to_proc

puts addition.call(5, 6)



Addition = lambda {|a, b| return a + b } # use this as your example!

Subtraction = lambda { } # your code between the braces

Multiplication = lambda { } # your code between the braces

Division = lambda { } # your code between the braces






puts lambda {}    #<Proc:0x000000007ce9f8@rbpl.rb:2 (lambda)>
puts Proc.new {}  #<Proc:0x000000007ce8b8@rbpl.rb:3>

#difference between proc and lambda

def a_method
 lambda { return "we just returned from the block" }.call
 return "we just returned from the calling method"
end
puts a_method

#we just returned from the calling method


def a_method
 Proc.new { return "we just returned from the block" }.call
 return "we just returned from the calling method"
end

puts a_method

#we just returned from the block


# 1. lambdas return some value to the calling method
# 2. proc doesn't return any value

# Lambda: A block created with lambda behaves like a method when you use return and simply exits the block, handing control back to the calling method.
# Proc: A block created with Proc.new behaves like it’s a part of the calling method when return is used within it, and returns from both the block itself as well as the calling method.

#1. Implicitly when invoking a method
#2. Explicitly using the Kernel#lambda factory method
#3. Explicitly using Proc.new

# The -> literal form is a shorter version of Kernel#lambda. (-> lambda also called stabby lambda)
short = ->(a, b) { a + b }
puts short.call(2, 3)
#5

long = lambda { |a, b| a + b }
puts long.call(2, 3)
#5


#Kernel#proc factory method is identical to Proc.new
#Note that proc is a method and not a literal form like -> nor a keyword like yield.

short = proc { |a, b| a + b }
puts short.call(2, 3)
#5

long = Proc.new { |a, b| a + b }
puts long.call(2, 3)
#5

