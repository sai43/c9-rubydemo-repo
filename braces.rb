# a=raw_input()
# tmp=True
# while(tmp):
#     b=len(a)
#     a=re.sub(r'\[\]|\{\}|\(\)','',a)
#     tmp=(b>len(a))
# print 'YES' if len(a)==0 else 'NO'


def valid_string?(string)
  open_paren =['[','{','(']
  close_paren =[']','}',')']
  open_close_hash ={"]"=>"[","}"=>"{",")"=>"("}
  stack =[]
  regex = Regexp.union(close_paren+open_paren)
  string.scan(regex).each do |char|
    if open_paren.include? char
      stack.push(char)
     elsif close_paren.include? char
        pop_val = stack.pop
         return false if pop_val != open_close_hash[char]
      end #if close
    end #each close
  open_paren.none?{|paren| stack.include? paren }
 end  #def close

# p valid_string?("[ ] } ]")  #=> false
# p valid_string?("[ ]")      #=> true
# p valid_string?("[  ")      #=> false
# p valid_string?("[ (] {}")  #=> false
# p valid_string?("[ ( ) ")   #=> false
# p valid_string?("[ ( text { ) } ]") #=> false
# p valid_string?("[ ( text ) {} ]")  #=> true


# def braces( values)
#     result = []
#   open_paren =['[','{','(']
#   close_paren =[']','}',')']
#   open_close_hash ={"]"=>"[","}"=>"{",")"=>"("}
#   stack =[]
#   regex = Regexp.union(close_paren + open_paren)
  
#   values.each do |i|
 
#   i.scan(regex).each do |char|
#     if open_paren.include? char
#       stack.push(char)
#      elsif close_paren.include? char
#         pop_val = stack.pop
#          return false if pop_val != open_close_hash[char]
#          # result << "NO" if pop_val != open_close_hash[char]
#          # result << "YES" if pop_val == open_close_hash[char]
#       end #if close
#     end #each close
#   open_paren.none?{|paren| stack.include? paren }
#  end #values each close
 
#   #puts result
# end #def close

def braces (values = [])
   result = []
   open_paren =['[','{','(']
   close_paren =[']','}',')']
   open_close_hash ={"]"=>"[","}"=>"{",")"=>"("}
   if values.length >= 1 && values.length <= 15
      values.each do |string|
        stack =[]
        regex = Regexp.union(close_paren + open_paren)
        p string 
        if  string.size >= 1 && string.size <= 100
           string.scan(regex).each do |char|
                if open_paren.include? char
                  stack.push(char)
                 elsif close_paren.include? char
                    pop_val = stack.pop
                     return false if pop_val != open_close_hash[char]
                  end #if close
           end # string each
          open_paren.none?{|paren| stack.include? paren } 
        end #if string
       end #values each
   end # if values 
end  #def braces

p braces(["[]{}", "[ ] } ]"])



def braces(values = [] )
  #unless values.length >= 15
      result = [] 
  open_paren =['[','{','(']
  close_paren =[']','}',')']
  open_close_hash ={"]"=>"[","}"=>"{",")"=>"("}
  stack =[]
  regex = Regexp.union(close_paren+open_paren)
  values.each do |string|
  p string
  string.scan(regex).each do |char|
    if open_paren.include? char
      stack.push(char)
     elsif close_paren.include? char
        pop_val = stack.pop
         return false if pop_val != open_close_hash[char]
      end #if close
    end #each close
  # open_paren.none?{|paren| stack.include? paren  }
     open_paren.none? do |paren| 
       if stack.include? paren 
         result << "NO"
       else
         result << "YES"
       end
    end
  end #values each close
   result
  #end
 end  #def close
 
 p braces(["[ ( text ) {} ]", "[ ( text ) {} ]", "[[]"]) 
 
 #braces(["[{]}", "[ ( text ) {} ]" ])

#=> true

# p valid_string?("[ ] } ]")  #=> false
# p valid_string?("[ ]")      #=> true
# p valid_string?("[  ")      #=> false
# p valid_string?("[ (] {}")  #=> false
# p valid_string?("[ ( ) ")   #=> false
# p valid_string?("[ ( text { ) } ]") #=> false
# p valid_string?("[ ( text ) {} ]")  #=> true
