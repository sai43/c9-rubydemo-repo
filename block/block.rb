# Block Examples

#Blocks are unnamed little code chunks you can drop into other methods. Used all the time.
#Procs are identical to blocks but you can store them in variables, which lets you pass them into functions as explicit arguments and save them for later. Used explicitly sometimes.
#Lambdas are really full methods that just haven't been named. Used rarely.
#Methods are a way of taking actual named methods and passing them around as arguments to or returns from other methods in your code. Used rarely.
#Closure is just the umbrella term for all four of those things, which all somehow involve passing around chunks of code.


[1,2,3].each { |x| puts x*2 }   # block is in between the curly braces

[1,2,3].each do |x|
  puts x*2                    # block is everything between the do and end
end



