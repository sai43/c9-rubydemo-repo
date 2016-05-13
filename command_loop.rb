
s = gets
puts s.upcase

puts "> "
s = gets
puts s.upcase



loop do
  print "> "
  input = gets
  puts "Input was: #{input.inspect}"
end


loop do
  print "> "
  input = gets
  puts "Input was: #{input.inspect}"
  break if input.nil?
end

print "> "
while input = gets do
  puts "Input was: #{input.inspect}"
  print "> "
end

while (print "> "; input = gets) do
  puts "Input was: #{input.inspect}"
end


while (print "> "; input = gets) do
  input.chomp!
  puts "Input was: #{input.inspect}"
end


while (print "> "; input = gets) do
  input.chomp!.downcase!
  puts "Input was: #{input.inspect}"
end


while (print "> "; input = gets) do
  input.chomp!
  puts "Input was: #{input.inspect}"
  case input
  when "time" then puts Time.now
  when "quit" then break
  else puts "I don't know that command"
  end
end



while (print "> "; input = gets) do
  input.chomp!
  puts "Input was: #{input.inspect}"
  case input
      when "time" then puts Time.now
      when "quit", "exit" then break
      else puts "I don't know that command"
  end
end

