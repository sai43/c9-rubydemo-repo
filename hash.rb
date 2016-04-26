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


#merging
h1 = { "a" => 100, "b" => 200 }
h2 = { "b" => 254, "c" => 300 }

p h1.merge(h2)                                                #=> {"a"=>100, "b"=>254, "c"=>300} 
p h1.merge(h2){|key, oldval, newval| newval - oldval}         #=> {"a"=>100, "b"=>54, "c"=>300}
p h1, h2                                                      #=>  {"a"=>100, "b"=>200}  {"b"=>254, "c"=>300}

p h1.merge!(h2){|key, oldval, newval| newval - oldval}        #=> {"a"=>100, "b"=>54, "c"=>300}
p h1, h2                                                      #=>  {"a"=>100, "b"=>54, "c"=>300}  {"b"=>254, "c"=>300}



student = {:name=>"saich", :add=>"hyd", :marks=>{:sub1=>76, :sub2=>87, :sub3=>65, :total=>89.05}}

student[:marks]             #=> {:sub1=>76, :sub2=>87, :sub3=>65, :total=>89.05}

#reject required k or values
student[:marks].reject {|k, v| k.to_s == 'total'}       #=> {:sub1=>76, :sub2=>87, :sub3=>65} 


sum = 0; student[:marks].reject{|k, v| k.to_s == 'total' }.each {|k, v| sum += v }
p sum   #=> 228


















