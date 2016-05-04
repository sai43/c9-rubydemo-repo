#Yielding to Blocks

#As you use blocks, you will discover that the most common usage involves passing exactly one block to a method. This pattern is extremely popular in the Ruby world, and you'll find yourself using it all the time.
#Ruby has a special keyword and syntax to make this pattern easier to use, and yes, faster! Meet the yield keyword, Ruby's implementation of the most common way of using blocks.

#without yield
def calculation(a, b, operation)
  operation.call(a, b)
end

puts calculation(5, 6, lambda { |a, b| a + b }) # addition  11
puts calculation(5, 6, lambda { |a, b| a - b }) # subtraction  -1

#As you can see, the calculation method accepts two numbers and a block that can perform a mathematical operation.

#with yield
def calculation(a, b)
  yield(a, b)
end

puts calculation(5, 6) { |a, b| a + b } # addition, 11
puts calculation(5, 6) { |a, b| a - b } # subtraction, -1


#As you can see, the results are identical. Feel free to play around with the example to get a better feel for the new syntax.

#Let me call out how the example using yield is different from the regular approach.

#The block is now no longer a parameter to the method. The block has been implicitly passed to the method - note how it's outside the parentheses.
#Yield makes executing the block feel like a method invocation within the method invocation rather than a block that's being explicitly called using Proc#call.
#You have no handle to the block object anymore - yield "magically" invokes it without any object references being involved.
#Note that blocks can be passed implicitly to methods without any parameters. The syntax remains the same.


#Here's an example where neither the method nor the block take any parameters.

def foo
 yield
end
foo { puts "sometimes shortcuts do get you there faster"  }

#sometimes shortcuts do get you there faster


#Magic Blocks

#I call yield "magical" because every object oriented rule in Ruby is suspended for this special mode of block invocation.
#Let's see what rules are bent, and what broken.

#1) Yield is not a method

def foo
 puts yield
 puts method(:foo)
 # uncomment the following line and see what happens! 
 #puts method(:yield)
end

foo { "I expect to be heard." }

#STDOUT:
# I expect to be heard.
# #<Method: Object#foo>

#2) Objects are abandoned

#Everything in Ruby is an object. Now where's the object that represents the block? How is yield getting access to it and seemingly invoking the call method on it?
#We don't know. As programmers using the language, all we can tell is that the normal rules have been suspended.

#If block not give - LocalJumpError

def foo
  yield
end

foo

# STDOUT:
# class: LocalJumpError
# message: no block given (yield)
# backtrace: yield.rb:76:in `foo'

#solution for block given exception

def foo
  yield if block_given?
end



#yield - make programm run fater

require "benchmark"

def calculation_with_explicit_block_passing(a, b, operation)
 operation.call(a, b)
end

def calculation_with_implicit_block_passing(a, b)
 yield(a, b)
end

Benchmark.bmbm(10) do |report|
 report.report("explicit") do
   addition = lambda { |a, b| a + b }
   1000.times { calculation_with_explicit_block_passing(5, 5, addition) }
 end

 report.report("implicit") do
   1000.times { calculation_with_implicit_block_passing(5, 5) { |a, b| a + b } }
 end
end


# block syntax

addition = lambda {|a, b| a + b }
puts addition.call(5, 5)

addition = lambda {|a, b|
 a + b
}
puts addition.call(5, 5)

addition = lambda do |a, b|
 a + b
end
puts addition.call(5, 5)

addition = lambda do |a, b|; a + b; end
puts addition.call(5, 5)


#Converting implicit blocks to explicit
#Sometimes, the performance benefits of implicit block invocation are outweighed by the need to have the block accessible as a concrete object.
#Ruby makes it very easy to convert blocks from implicit to explicit and back again, but requires special syntax for this.


#Let's start with converting implicit to explicit.
#Example Code:

def calculation(a, b, &block) # &block is an explicit (named) parameter
 block.call(a, b)
end
 
puts calculation(5, 5) { |a, b| a + b } # this is an implicit block
                                        # -- it is nameless and is not 
                                        # passed as an explicit parameter.
                                        
 
 
#Now, the other way - explicit to implicit.
#Example Code:

def calculation(a, b)
  yield(a, b) # yield calls an implicit (unnamed) block 
end
 
addition = lambda {|x, y| x + y}
puts calculation(5, 5, &addition) # like our last example, &addition is 
                                  # an explicit (named) block 
                                  # -- but `yield` can still call it!
                                  
                                  
# So from these two examples, we derive a simple set of syntactic rules to convert blocks from one form to the other:

#1. The block should be the last parameter passed to a method.
#2. Placing an ampersand (&) before the name of the last variable triggers the conversion.

