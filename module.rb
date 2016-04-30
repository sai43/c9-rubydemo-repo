#http://ruby-doc.org/core-2.3.0/Module.html

#Modules Are Like Hashes

#mystuff = {'apple' => "I AM APPLES!"}
#puts mystuff['apple']

# module MyStuff
#     def MyStuff.apple()
#         puts "I AM APPLES!"
#     end

   # this is just a variable
   #TANGERINE = "Living reflection of a dream"
    
# end


#mystuff['apple'] # get apple from dict
#MyStuff.apple() # get apple from the module
#MyStuff::TANGERINE # same thing, it's just a variable



# fred = Module.new do
#  def meth1
#     "hello"
#  end
#  def meth2
#     "bye"
#  end
# end
# a = "my string"
# p a.methods.count
# p a.class
# p fred.class
# p a.extend(fred)   #=> "my string"
# p a.methods.count
# p a.meth1          #=> "hello"
# p a.meth2          #=> "bye"


p Math.constants
p Math.instance_methods   

p Math::PI
p Math::E


# for module specification between two modules Scope resolution operator Module1::Module2
# for one module and on class we seperate using Module.Class





