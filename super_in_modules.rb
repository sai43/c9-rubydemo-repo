

# When authoring a reusable module, we may find we want to call a
# superclass method, but only if it exists. For instance, here's a
# module which defines its own =#hello= method. We want to be able to
# include it in many different classes, some of which may inherit from
# other classes that define =#hello=. 

# If the class it is included in also inherits a =#hello= method from
# somewhere else, the module will simply embellish its output a bit. But
# since the including class might /not/ define a =#hello= method, the
# module also includes its own full implementation. The question is, how
# do we tell if an ancestor implements =#hello=?

module YeOlde
  def hello(subject="World")
    if ???
      super
    else
      "Good morrow, #{subject}!"
    end
    puts "Well met indeed!"
  end
end

# The answer is to use Ruby's =defined?= operator, with =super= as its
# argument.

# When we include this module in a class whose parent defines =#hello=,
# it uses the parent greeting. When we include it in a class with no
# =#hello= method, it uses its own greeting.

module YeOlde
  def hello(subject="World")
    if defined?(super)
      super
    else
      puts "Good morrow, #{subject}!"
    end
    puts "Well met indeed!"
  end
end

class Greeter
  def hello(subject)
    puts "Hello, #{subject}"
  end
end

class GreeterChild < Greeter
  include YeOlde
end

class NonGreeter
  include YeOlde
end

GreeterChild.new.hello("Bob")
NonGreeter.new.hello("Sally")

# #+RESULTS:
# : Hello, Bob
# : Well met indeed!
# : Good morrow, Sally!
# : Well met indeed!

# Let's look at another situation involving the use of =super= in a
# module. Let's say we have a module which defines a =#logged_send=
# method. =#logged_send= acts just like a call to Ruby's =#send=, except
# it also logs the method call and arguments.

# #+name: logged1

module Logged
  def logged_send(name, *args, &block)
    puts "Sending #{name}(#{args.map(&:inspect).join(', ')})"
    send(name, *args, &block)
  end
end

# When we include this module in most classes it works just fine.

module Logged
  def logged_send(name, *args, &block)
    puts "Sending #{name}(#{args.map(&:inspect).join(', ')})"
    send(name, *args, &block)
  end
end

class Greeter
  include Logged

  def hello(subject)
    puts "Hello, #{subject}"
  end
end

Greeter.new.logged_send(:hello, "Major Tom")

# #+RESULTS:
# : Sending hello("Major Tom")
# : Hello, Major Tom

# But one day we add in another module which overrides =#send= to do
# something completely different. Suddenly, =#logged_send= doesn't work
# so well.

# #+name: pigeonpost

module PigeonPost
  def send(*messages)
    # ...
    puts "Your message is winging its way to its recipient!"
  end
end

module Logged
  def logged_send(name, *args, &block)
    puts "Sending #{name}(#{args.map(&:inspect).join(', ')})"
    send(name, *args, &block)
  end
end

module PigeonPost
  def send(*messages)
    # ...
    puts "Your message is winging its way to its recipient!"
  end
end

class Greeter
  include PigeonPost
  include Logged

  def hello(subject)
    puts "Hello, #{subject}"
  end
end

Greeter.new.logged_send(:hello, "Major Tom")

# #+RESULTS:
# : Sending hello("Major Tom")
# : Your message is winging its way to its recipient!

# The problem here is that when the =Logged= module called =#send=,
# expecting the default =Object= implementation of =#send=, it got the
# =PigeonPost= implementation instead.

# How can we ensure that =Logged= always gets the original definition of
# =#send=? Let's take it step by step. Inside the =#logged_send= method,
# we first need to get a method object referring to the original
# definition of =#send= from the =Object= class.

# #+name: instancemethod

original_send = Object.instance_method(:send)

# #+RESULTS:
# : #<UnboundMethod: Object(Kernel)#send>

# This yields an =UnboundMethod= object. This object then needs to be
# bound to a specific object instance, in this case =self=.

original_send = Object.instance_method(:send)
bound_send = original_send.bind(self)

# #+RESULTS:
# : #<Method: Object(Kernel)#send>

# This results in a callable =Method= object.

# The last step is to call the =Method= object.

bound_send.call(name, *args, &block)

# When we put it all together and try again, things work as intended!

# #+name: logged2

module Logged
  def logged_send(name, *args, &block)
    puts "Sending #{name}(#{args.map(&:inspect).join(', ')})"
    original_send = Object.instance_method(:send)
    bound_send = original_send.bind(self)
    bound_send.call(name, *args, &block)
  end
end
