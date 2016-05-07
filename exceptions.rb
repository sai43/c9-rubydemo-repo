#Exception

#The execution and the exception always go together. 
#If you are opening a file, which does not exist, 
#then if you did not handle this situation properly, 
#then your program is considered to be of bad quality.

# The program stops if an exception occurs. 
# So exceptions are used to handle various type of errors, 
# which may occur during a program execution and 
# take appropriate action instead of halting program completely.

#Ruby provide a nice mechanism to handle exceptions. We enclose the code that could raise an exception in a begin/end block and 
# use rescue clauses to tell Ruby the types of exceptions we want to handle.

# begin  
#   # -  
# rescue OneTypeOfException  
#   # -  
# rescue AnotherTypeOfException  
#   # -  
# else  
#   # Other exceptions
# ensure
#   # Always will be executed
# end

# Everything from begin to rescue is protected. If an exception occurs during the execution of 
# this block of code, control is passed to the block between rescue and end.

# For each rescue clause in the begin block, Ruby compares the raised Exception against each of
# the parameters in turn. The match will succeed if the exception named in the rescue clause is
# the same as the type of the currently thrown exception, or is a superclass of that exception.

# In an event that an exception does not match any of the error types specified, we are allowed
# to use an else clause after all the rescue clauses.

#Using retry Statement:

# begin
#     # Exceptions raised by this code will 
# 	# be caught by the following rescue clause
# rescue
#     # This block will capture all types of exceptions
#     retry  # This will move control to the beginning of begin
# end

begin
   file = open("/unexistant_file")
   if file
      puts "File opened successfully"
   end
rescue
   fname = "existant_file"
   retry
end

# The following is the flow of the process:
# an exception occurred at open
# went to rescue. fname was re-assigned
# by retry went to the beginning of the begin
# this time file opens successfully
# continued the essential process.

# NOTE: Notice that if the file of re-substituted name does not exist this example code retries infinitely. Be careful if you use retry for an exception process.



#using raise statement

# raise 
# OR
# raise "Error Message" 
# OR
# raise ExceptionType, "Error Message"
# OR
# raise ExceptionType, "Error Message" condition

#ex1:
begin  
    puts 'I am before the raise.'  
    raise 'An error has occurred.'  
    puts 'I am after the raise.'  
rescue  
    puts 'I am rescued.'  
end  
puts 'I am after the begin block.' 

#ex2:
begin  
  raise 'A test exception.'  
rescue Exception => e  
  puts e.message  
  puts e.backtrace.inspect  
end  



# using ensure statement 

# begin 
#   #.. process 
#   #..raise exception
# rescue 
#   #.. handle error 
# ensure 
#   #.. finally ensure execution
#   #.. This will always execute.
# end

#ex:
begin
  raise 'A test exception.'
rescue Exception => e
  puts e.message
  puts e.backtrace.inspect
ensure
  puts "Ensuring execution"
end

#Using else Statement

# begin 
#   #.. process 
#   #..raise exception
# rescue 
#   # .. handle error
# else
#   #.. executes if there is no exception
# ensure 
#   #.. finally ensure execution
#   #.. This will always execute.
# end

#ex;

begin
 # raise 'A test exception.'
 puts "I'm not raising exception"
rescue Exception => e
  puts e.message
  puts e.backtrace.inspect
else
   puts "Congratulations-- no errors!"
ensure
  puts "Ensuring execution"
end

#Catch and Throw:
#syntax

# throw :lablename
# #.. this will not be executed
# catch :lablename do
# #.. matching catch will be executed after a throw is encountered.
# end

# OR

# throw :lablename condition
# #.. this will not be executed
# catch :lablename do
# #.. matching catch will be executed after a throw is encountered.
# end

#Ex:

def promptAndGet(prompt)
   print prompt
   res = readline.chomp
   throw :quitRequested if res == "!"
   return res
end

catch :quitRequested do
   name = promptAndGet("Name: ")
   age = promptAndGet("Age: ")
   sex = promptAndGet("Sex: ")
   # ..
   # process information
end
promptAndGet("Name:")



#some keywords in exception class
#begin
    #raise
    #rescue
    #retry
    #else
    #ensure
#end
#catch
#throw

#http://ruby-doc.org/core-2.3.0/Exception.html

#The built-in subclasses of Exception are:

# NoMemoryError
# ScriptError
# LoadError
# NotImplementedError
# SyntaxError
# SecurityError
# SignalException
# Interrupt
# StandardError -- default for rescue
# ArgumentError
# UncaughtThrowError
# EncodingError
# FiberError
# IOError
# EOFError
# IndexError
# KeyError
# StopIteration
# LocalJumpError
# NameError
# NoMethodError
# RangeError
# FloatDomainError
# RegexpError
# RuntimeError -- default for raise
# SystemCallError
# Errno::*
# ThreadError
# TypeError
# ZeroDivisionError
# SystemExit
# SystemStackError
# fatal – impossible to rescue
# Public Class Methods


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


