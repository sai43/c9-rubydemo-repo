# if 
# if else
# elsif
# if modifier
# unless
# unless modifier
# case

# Expression & Statment
# expression always return value - methods
# statements never return value - conditional statment like if(other languages)

# if condition 
#     true
# else
#     false
# end

#example for only if statment
# age = 18
# if age >= 18
#     p "He is young"
# end


#example for if else statement
# print "Enter Your Name: \t"
# name = gets.chomp
# if name == 'Ruby'
#     print "Hi Ruby - Now time is : #{Time.now} \n"
# else
#     print "Hi #{name}\n"
# end

#example for if elsif stament

# print "Enter age: \t"
# age = gets.to_i

# if age < 18
#     p "children"
# elsif age == 18...30
#     p "young"
# elsif age == 31..75
#     p "middle"
# else
#     p "May be he is ............."
# end

# order = { :size => "egfne" }

# def make_medium_coffee
#     puts "making medium statement"
# end

# def make_small_coffee
#     puts "making small statement"
# end

# def make_large_coffee
#     puts "making large statement"
# end

# def make_coffee
#   puts "making statement"
# end


# #assume other functions
# if order[:size] == "small"
#     make_small_coffee
# elsif order[:size] == "medium"
#     make_medium_coffee
# elsif order[:size] == "large"
#     make_large_coffee
# else
#     make_coffee
# end


# example for if as modifier
#age  = 15
#age = 18 if age < 16
#p age



#age = 16
# if !(age <= 18)
#     p "young"
# else
#     p "child"
# end

# unless age > 18
#     p "young"
# else
#     p "child"
# end


# example for unless as modifier
# age  = 15
# age = 18 unless age >  16
# p age

# print "Enter age: \t"
# age = gets.to_i

# case age
# when 10..17
#     p "children"
# when 18..30
#     p "young"
# when 31..75
#     p "middle"
# when 76..100
#     p "older"
# else
#     p "I am not sure"
# end
