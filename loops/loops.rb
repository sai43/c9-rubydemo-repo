
#while - it execute when it recieve true value
#while conditional [do]
# code
#end

$i = 0
$num = 5

while $i < $num  do
   puts("Inside the loop i = #$i" )
   $i +=1
end

#while modifier

# code while condition

#OR

# begin 
#   code 
# end while conditional

$i = 0
$num = 5
begin
   puts("Inside the loop i = #$i" )
   $i +=1
end while $i < $num


#until - it execute when it recieve false value
#  until conditional [do]
#    code
#  end

$i = 0
$num = 5

until $i > $num  do
   puts("Inside the loop i = #$i" )
   $i +=1;
end


#until modifier
# code until conditional

# OR

# begin
#   code
# end until conditional

$i = 0
$num = 5
begin
   puts("Inside the loop i = #$i" )
   $i +=1;
end until $i > $num


#for
#  for variable [, variable ...] in expression [do]
#    code
#  end
# i is local variable
for i in 0..5
   puts "Value of local variable is #{i}"
end

#each
#(expression).each do |variable[, variable...]| code end

(0..5).each do |i|
   puts "Value of local variable is #{i}"
end

#break
#terminates the most internal loop. 
#Terminates a method with an associated block if called within the block (with the method returning nil).

for i in 0..5
   if i > 2 then
      break
   end
   puts "Value of local variable is #{i}"
end

#next
#Jumps to next iteration of the most internal loop.
#Terminates execution of a block if called within a block (with yield or call returning nil).
for i in 0..5
   if i < 2 then
      next
   end
   puts "Value of local variable is #{i}"
end

#redo
#Restarts this iteration of the most internal loop, 
#without checking loop condition. Restarts yield or call if called within a block.

for i in 0..5
   if i < 2 then
      puts "Value of local variable is #{i}"
      redo
   end
end

#retry
#If retry appears in rescue clause of begin expression, restart from the beginning of the 1begin body.

# begin
#   do_something # exception raised
# rescue
#   # handles error
#   retry  # restart from beginning
# end

#if retry appears in the iterator, the block, or the body of the for expression, 
#restarts the invocation of the iterator call. Arguments to the iterator is re-evaluated.

# for i in 1..5
#   retry if some_condition # restart from i == 1
# end


for i in 1..5
   retry if  i > 2
   puts "Value of local variable is #{i}"
end

# (0..5).each do |i|
#  puts "Value: #{i}"
#  retry if i > 2
# end


# redo and retry are both used to re-execute parts of a loop.
# But they differ in how much they re-execute: redo only repeats the current iteration,
# while retry repeats the whole loop from the start.


