
?c                              # => "c"
?q                              # => "q"


case $stdin.getc.downcase
when ?y then puts "Proceeding..."
when ?n then puts "Aborting."
else puts "I don't understand"
end


# string[2]
# #=> 99
# ?c
# #= 99
# string[2] == ?c
# #=> true
