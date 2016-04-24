# command to make selected lines as commantable and vise versa use: cntrl + / 


# #Create an Array Empty 
# a = []
# #b = Array.new

# #Initialize an Array with arrayliteral
# #marks = [89, 54, 43, 25, 85, 'student1', 98.34343]
# #print marks


# #assign or store values to Array
# a[0]   =  43
# a[4]   =  'Ruby'
# a[10]  =  89.432432432

# # insert or push values to the array
# a.push('hello newbie')
# a.push(12566)
# a << "Thank you"
# a << "welcome"


# #Fetch or get values from array with index based
# #puts a[9]
# #print "#{a[10]} \n"
# p a   #[43, nil, nil, nil, "Ruby", nil, nil, nil, nil, nil, 89.432432432, "hello newbie", 12566, "Thank you"]

# #remove or pop elements from array
# a.pop


# #a.each_with_index {|value, index| puts "#{index} => #{value}"}

# # returns object class name
# p a.class

# #object unique identifier i.e object_id
# p a.object_id

# #returns methods available for object a
# p a.methods

# #lenght or size of the array
# p a.size
# p a.length
# p a.count

# #return all not nil values from array
# modified = a.compact
# p modified #[43, "Ruby", 89.432432432, "hello newbie", 12566, "Thank you"]


#Enumurators in ruby array

#collect
#select
#reject
#map
#each
#inject
#reduce
list = (1..10).to_a
 p list
 p list.each {|i| print "#{i} \t "}
 p list.collect { |i| i >= 3 && i <= 7 }   #return boolean values
 p list.map { |i| i >= 3 && i <= 7 }       #return boolean values
 p list.select { |i| i >= 3 && i <= 7 }    #return element values, which elemets satistfy the condition
 p list.reject { |i| i >= 3 && i <= 7 }     #return element values, which are not satistfy the condition
 p list.reduce(:+)
 
 # Sum some numbers
p (5..10).reduce(:+)                             #=> 45
# Same using a block and inject
p (5..10).inject { |sum, n| sum + n }            #=> 45
# Multiply some numbers
p (5..10).reduce(1, :*)                          #=> 151200
# Same using a block
p (5..10).inject(1) { |product, n| product * n } #=> 151200
# find the longest word
longest = %w{ cat sheep bear }.inject do |memo, word|
   memo.length > word.length ? memo : word
end
p longest                                        #=> "sheep"
