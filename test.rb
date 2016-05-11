puts 'hello world'
#ruby modules are like hashes

# module are class name always starts with Capital letter and every word first letter should be capital ....

# mathtest = {pi: 3.1414346464}
# p mathtest[:pi]


# module MathTest
#     def self.pi()
#         return 3.14141414143435436346
#     end
    
#     PI = 4.134343234
  
# end
# p MathTest.pi
# p MathTest::PI

# class MathTest
    
#     def initialize(pi)
#         @pi = pi
#     end
    
#     def pi
#         @pi 
#     end
# end

# #by using object we can excute or access definitions or variables
# #objects or like require
# obj = MathTest.new(3.1414124324245)
# p obj.pi()

class Person
    def initialize(name, age, address)  
        # name  = name
        # age  = age
        # address = address
        @name = name
        @age = age
        @address = address
    end
    
    
    #attr_reader :name, :age, :address   #getter methods for name, age, address
    #attr_writer :name, :age, :address   #setter methods for name, age, address
    
    attr_accessor  :name, :age, :address  #for both getter and setter methods for thos 3 variables
  
    # Setter Methods
    
    # def name=(name)
    #   @name = name
    # end
    
    # def age=(age)
    #     @age = age
    # end
   
    # def address=(address)
    #     @address = address
    # end
    
    
  
  #Getter Methods
    # def name
    #     "person name is : #{@name}"
    # end
    
    # def address
    #   "and he stay at : #{@address}"
    # end
    
    # def age
    #     "#{@age}"
    # end
    
    
    
end

person = Person.new('saich', 24, 'Hyd')

p person.methods

p person.name
p person.address
p person.age
p person.inspect

p person.name = 'rubyist'
p person.age = 1993
p person.address = 'Tokyo'
p person.inspect

