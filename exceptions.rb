#Exception

#raise
#rescue
#ensure
#begin
#end
#catch
#throw

def raise_exception  
  puts 'I am before the raise.'  
  raise 'An error has occured'  
  puts 'I am after the raise'  
end  
raise_exception  


def inverse(x)  
  raise ArgumentError, 'Argument is not numeric' unless x.is_a? Numeric  
  1.0 / x  
end  
puts inverse(2)  
puts inverse('not a number') 

#Defining new exception classes: 
#To be even more specific about an error, you can define your own Exception subclass:

class NotInvertibleError < StandardError  
end


def raise_and_rescue  
  begin  
    puts 'I am before the raise.'  
    raise 'An error has occured.'  
    puts 'I am after the raise.'  
  rescue  
    puts 'I am rescued.'  
  end  
  puts 'I am after the begin block.'  
end  
raise_and_rescue 

#sample output

#I am before the raise.  
# I am rescued.  
# I am after the begin block. 


#note:
#RuntimeError (this is the default exception raised by the raise method), 
#NoMethodError, NameError, IOError, TypeError and ArgumentError.


