
# Ruby programs, like pretty much any kind of program, start out with
# two output channels: standard out and standard error. As you know, we
# typically communicate with standard out by calling =puts=.

puts "This goes to standard out"
# >> This goes to standard out

# While writing to the standard streams is sufficient in command-line
# applications and in demonstration scripts, in larger applications it's
# often useful to capture a program's output. We may want to ship the
# output off to another machine, store it for later examination, or
# present it to the user in GUI or web browser.

# Today we'll look at how to redirect output and capture it as a
# string. But first, let's dig into how the standard streams are handled
# in Ruby.

# When we write =puts=, that's actually short for =$stdout.puts=:

$stdout.puts "This goes to standard out"
# >> This goes to standard out

# =$stdout= is a special global variable that points to an =IO= object
# for the standard output stream. There is a similar =$stderr= variable
# for the standard error stream.

$stderr.puts << "This goes to standard error"

# One simple way to capture output is to reassign the =$stdout= variable
# to some other object which can store up the output. Let's write a
# method to do that. We need some kind of object which behaves like an
# IO object but stores the output into a string instead of writing it to
# the console. Ruby gives us just such an object, in the form of the
# =StringIO= class. We require the 'stringio' library, and instantiate a
# new =StringIO= object. We save the old value of =$stdout=, set it to
# point to our =StringIO=, and execute the given block. Once the block
# is finished, we restore the original $stdout. We do this inside an
# ensure clause to make sure it happens even if an exception was raised
# from within the block. Then we return the =String= buffer from inside
# the =StringIO=.

# When we wrap this around a puts statement, the output is captured to a
# string.

require 'stringio'

def capture_output
  fake_stdout = StringIO.new
  old_stdout = $stdout
  $stdout = fake_stdout
  yield
ensure
  $stdout = old_stdout
  return fake_stdout.string
end

output = capture_output do
  puts "This goes to standard out"
end
output # => "This goes to standard out\n"

# Ruby has another name for standard out: a constant named =STDOUT= (in
# all caps). This constant is unaffected by changes to the =$stdout=
# global, so we can bypass the capture by explicitly referencing the
# =STDOUT= constant inside our capture block.

output = capture_output do
  puts "This goes to standard out"
  STDOUT.puts "This bypasses capture"
end
output # => "This goes to standard out\n"
# >> This bypasses capture

# If we are seeking a more complete capture, we could reassign this
# constant too. But that results in Ruby warnings, and it's kind of
# against the spirit of having =STDOUT= be a constant. So I wouldn't
# advise it.

require 'stringio'

def capture_output
  fake_stdout = StringIO.new
  old_stdout = $stdout
  $stdout = fake_stdout
  Object.const_set(:STDOUT,fake_stdout) # !> already initialized constant STDOUT
  yield
ensure
  $stdout = old_stdout
  Object.const_set(:STDOUT,old_stdout) # !> already initialized constant STDOUT
  return fake_stdout.string
end

output = capture_output do
  puts "This goes to standard out"
  STDOUT.puts "This tries to bypass capture"
end
output
# => "This goes to standard out\nThis tries to bypass capture\n"

# And in any case, it's still an imperfect capture strategy. Let's look
# at what happens when we output some text to standard out from within a
# subprocess:

require 'stringio'

def capture_output
  fake_stdout = StringIO.new
  old_stdout = $stdout
  $stdout = fake_stdout
  Object.const_set(:STDOUT,fake_stdout) # !> already initialized constant STDOUT
  yield
ensure
  $stdout = old_stdout
  Object.const_set(:STDOUT,old_stdout) # !> already initialized constant STDOUT
  return fake_stdout.string
end

output = capture_output do
  puts "This goes to standard out"
  STDOUT.puts "This tries to bypass capture"
  system 'echo "output from a subprocess"'
end
output
# => "This goes to standard out\nThis tries to bypass capture\n"
# >> output from a subprocess

# Subprocesses have no knowledge of Ruby variables. They just use the
# original process standard output and error streams. There are ways to
# explicitly redirect subprocess output in Ruby, but that means every
# subprocess invocation has to be modified. That doesn't really help us
# construct a general purpose output-capture method.

# Instead, let's try a different tactic. This time, instead of
# constructing a =StringIO= object, we'll construct an operating
# system-level pipe. The =IO.pipe= method returns two objects: the read
# end and the write end of the newly-created pipe. We turn on =sync=
# mode on the read end of the pipe: this will ensure that data is
# immediately available from it, rather than having to wait until some
# operating system buffer is full.

# We save a clone of =$stdout=, so that we can restore it again
# later. Then we use the =#reopen= method on the =$stdout= stream to
# change =$stdout= in-place to point to the pipe's write end. Now
# anything written to standard output, regardless of whether it uses the
# =$stdout= global or the =STDOUT= constant, will go into our new pipe
# instead.

# Now we need to arrange get data back *out* of the pipe. First, we
# define a string to act as an output buffer. Then we kick off a very
# simple thread. Its job will be to continually try to read data from
# the pipe, and append that data to our output buffer. =readpartial=
# will read as many bytes as it can, up to the given maximum. If there
# is no data available it will block until there is.

# We then yield to the given block. Once it has finished, we close the
# read end of the pipe. This will cause an =EOFError= to be raised in
# our reader thread, terminating it. We wait until the thread is done
# shutting down, then restore the =$stdout= stream to its original
# state using another =#reopen=. Finally, we returned the captured
# buffer.

# When we test this new version out, we can see that it captures even
# output generated from within a subprocess.

def capture_output
  old_stdout = STDOUT.clone
  pipe_r, pipe_w = IO.pipe
  pipe_r.sync    = true
  output         = ""
  reader = Thread.new do
    begin
      loop do
        output << pipe_r.readpartial(1024)
      end
    rescue EOFError
    end
  end
  STDOUT.reopen(pipe_w)
  yield
ensure
  STDOUT.reopen(old_stdout)
  pipe_w.close
  reader.join
  return output
end

output = capture_output do
  puts "This goes to standard out"
  STDOUT.puts "This tries to bypass capture"
  system 'echo "output from a subprocess"'
end
output.split("\n")
# => ["This goes to standard out",
#     "This tries to bypass capture",
#     "output from a subprocess"]

