#ranges in ruby is know starting_value..ending_value
#ex: 
# 1..10   #=> this is provide the range values include ending value
# 1...10  #=> this type of range provide exclude the ending value

alphabets = 'A'..'Z'
print alphabets.to_a
puts "\n"


list = (1..10)
list.each {|i| print i}
puts "\n"
list2 = 1...10
list2.each {|i| print i}
puts "\n"

range = 1939..1945
p range.to_a #to_a means convert result into array (to_s, to_a, to_h, to_i, to_f)

#p float_range = (7.000..8.997).to_a

p char_range = ('aaa'..'abc').to_a

p char_range.include? "abb"
p char_range.include? "aba"
