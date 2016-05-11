
#Ruby provides a whole set of I/O-related methods implemented in the Kernel module. 
#All the I/O methods are derived from the class IO.

#The class IO provides all the basic methods, 
#such as read, write, gets, puts, readline, getc,putc, and printf.

#
# You can create a File object using File.new method for reading, writing, or both,
# according to the mode string. Finally, you can use File.close method to close that file.

# File.new
#syntax
# aFile = File.new("filename", "mode")
#    # ... process the file
# aFile.close

#File.open

# You can use File.open method to create a new file object and assign that file object to a file. 
# However, there is one difference in between File.open and File.new methods. 
# The difference is that the File.open method can be associated with a block, 
# whereas you cannot do the same using the File.new method.

#syntax
# File.open("filename", "mode") do |aFile|
#   # ... process the file
# end


# Modes	Description
# r  -	Read-only mode. The file pointer is placed at the beginning of the file. This is the default mode.
# r+ -	Read-write mode. The file pointer will be at the beginning of the file.
# w	 - Write-only mode. Overwrites the file if the file exists. If the file does not exist, creates a new file for writing.
# w+ - Read-write mode. Overwrites the existing file if the file exists. If the file does not exist, creates a new file for reading and writing.
# a  -	Write-only mode. The file pointer is at the end of the file if the file exists. That is, the file is in the append mode. If the file does not exist, it creates a new file for writing.
# a+ -	Read and write mode. The file pointer is at the end of the file if the file exists. The file opens in the append mode. If the file does not exist, it creates a new file for reading and writing.


#sysread
aFile = File.new("input.txt", "r")
if aFile
   content = aFile.sysread(20)
   puts content
else
   puts "Unable to open file!"
end


#syswrite
aFile = File.new("input.txt", "r+")
if aFile
   aFile.syswrite("ABCDEF")
else
   puts "Unable to open file!"
end


#each_byte
aFile = File.new("input.txt", "r+")
if aFile
   aFile.syswrite("ABCDEF")
   aFile.each_byte {|ch| putc ch; putc ?. }
else
   puts "Unable to open file!"
end


#IO.readlines
arr = IO.readlines("input.txt")
puts arr[0]
puts arr[1]


#IO.foreach
IO.foreach("input.txt"){|block| puts block}

#Renaming and Deleting Files
# Rename a file from test1.txt to test2.txt
File.rename( "test1.txt", "test2.txt" )

# Delete file test2.txt
File.delete("test2.txt")


#File Modes and Ownership
file = File.new( "test.txt", "w" )
file.chmod( 0755 )

# Mask	Description
# 0700	rwx mask for owner
# 0400	r for owner
# 0200	w for owner
# 0100	x for owner
# 0070	rwx mask for group
# 0040	r for group
# 0020	w for group
# 0010	x for group
# 0007	rwx mask for other
# 0004	r for other
# 0002	w for other
# 0001	x for other
# 4000	Set user ID on execution
# 2000	Set group ID on execution
# 1000	Save swapped text, even after use


#File Inquiries
File.open("file.rb") if File::exists?( "file.rb" )

File.file?( "text.txt" )

# a directory
File::directory?( "/usr/local/bin" ) # => true

# a file
File::directory?( "file.rb" ) # => false

File.readable?( "test.txt" )   # => true
File.writable?( "test.txt" )   # => true
File.executable?( "test.txt" ) # => false

File.zero?( "test.txt" )      # => true to check file size 0 or not
File.size?( "text.txt" )     # => 1002, return size of file
File::ftype( "test.txt" )     # => file, to findout a type of file

#The ftype method identifies the type of the file by returning one of the following: 
#file, directory, characterSpecial, blockSpecial, fifo, link, socket, or unknown.

#to find when a file was created, modified, or last accessed 
File::ctime( "test.txt" ) # => Fri May 09 10:06:37 -0700 2008
File::mtime( "text.txt" ) # => Fri May 09 10:44:44 -0700 2008
File::atime( "text.txt" ) # => Fri May 09 10:45:01 -0700 2008


#Directories 
#To change directory within a Ruby program
Dir.chdir("/usr/bin") 
#To find out what the current directory
puts Dir.pwd
#To get a list of the files and directories within a specific directory
puts Dir.entries("/usr/bin").join(' ')
#synonym
Dir.foreach("/usr/bin") do |entry|
   puts entry
end
#or
Dir["/usr/bin/*"]

#to create directory
Dir.mkdir("mynewdir")
#NOTE: The mask 755 sets permissions owner, group, world [anyone] to rwxr-xr-x where r = read, w = write, and x = execute.
Dir.mkdir( "mynewdir", 755 )

#to dlete directory
Dir.delete("testdir")


#temporary files & directories
require 'tmpdir'
   tempfilename = File.join(Dir.tmpdir, "tingtong")
   tempfile = File.new(tempfilename, "w")
   tempfile.puts "This is a temporary file"
   tempfile.close
   File.delete(tempfilename)
   
require 'tempfile'
   f = Tempfile.new('tingtong')
   f.puts "Hello"
   puts f.path
   f.close
   
   















