#hash contians values as hash, array, string, symbole, integer etc...
#in hash key and value is seperated with =>(rocket symbole)
#hash is store the data in dictionary format

#create empty hash
# hash1 = {}
# hash2 = Hash.new

# p hash1.class
# p hash2.class

# p hash1

# #create hash with some values

# grades = { "Jane Doe" => 10, "Jim Doe" => 6 }
# p grades.class
# p grades

# #accessing values
# p grades["Jim Doe"]  => 6

# #modify or assign value to some key
# p grades["Jim Doe"] = 8
# p grades

# student = Hash.new
# student["name"] = 'rubydev'
# student[:city] = 'Tokyo - Japan'
# student[:status] = 'AVG'
# student["marks"] = 89.99

# p student["name"]
# p student[:city]
# p student["marks"]
# p student[:marks]

# student = {:name => "sai", :city => "hyd", :status => "Dev"}
# p student

 student = {name: 'sai', city: 'hyd-IN', status: 'dev'}
# p student
# p student[:city]

p student.methods

#return the all key names
p student.keys

#return the all values
p student.values
#to display all elements inside current hash
student.each {|key, value| p "#{key} - #{value}"}











