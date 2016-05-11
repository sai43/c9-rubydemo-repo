$global_variable = 10
class Class1
    @@class_var = 43
    @@a = 15
    @instance_var = 'instamce var'
    puts "instance varibale in class1 is #@instance_var"
    local_var = 'local var'
    sum = 0
  def print_global
     local_var = 23
     puts "Global variable in Class1 is #$global_variable"
     puts "Class variable in class1 is #@@class_var"
     puts "local variable in def is #{local_var} "
  end
  puts "local variable in class1 is #{local_var}"
end
class Class2 < Class1
     @@class_var = 690
     @@b = 15
     local_var = 3.141414
     puts "local variable in class2 is #{local_var}"
     @instance_var = 4
     puts "instance varibale in class2 is #@instance_var"


  def print_global
     # @instance_var = 'method instance var'
     puts "Global variable in Class2 is #$global_variable"
     puts "Class variable in class2 is #@@class_var"
     puts "instance varibale in class2 def is #@instance_var"
  end
end

class1obj = Class1.new
class1obj.print_global
class2obj = Class2.new
class2obj.print_global


#Polymorphism concept and reason for ruby is more dynamic
class Poly
    def add a, b
     puts  a + b
    end
end

# def outer
#     puts "local"
# end

# # outer 
# p outer.methods


# po = Poly.new
# po.add 12, 42
# po.add 'hello', 'string' 
# po.add 23.42423, 12.235435

class Test
   def inc(n)
    sum = 0
     (1..n).each do |i|
       sum += i
     end
     puts sum
   end
end

ob = Test.new
ob.inc 5
