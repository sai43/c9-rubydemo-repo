# aFile = File.new("rubydemo.rb", "r")
# if aFile
#   content = aFile.sysread(200)
#   puts content
# else
#   puts "Unable to open file!"
# end

# aFile = File.new("rubydemo.rb", "r+")
# if aFile
#   aFile.syswrite("ABCDEF")
# else
#   puts "Unable to open file!"
# end


# aFile = File.new("input.txt", "r+")
# if aFile
#   aFile.each_byte {|ch| putc ch; putc ?. }
# else
#   puts "Unable to open file!"
# end

#arr = IO.readlines("input.txt")

#IO.foreach("input.txt"){|block| puts block}

#File.rename( "input.txt", "input2.txt" )

#File Inquiries
p File.open("input2.txt") if File::exists?( "input2.txt" )

p File.file?( "input2.txt" )

# a directory
p File::directory?( "/usr/local/bin" ) # => true

# a file
p File::directory?( "input2.txt" ) # => false

puts Dir.entries("/home/ubuntu/workspace/snippets/modules").join(',')

require 'tempfile'
   f = Tempfile.new('tempfiletest.rb')
   f.puts "puts Hello"
   puts f.path
   f.close
   