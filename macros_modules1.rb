
# Our client, the colonial fleet command, has asked us for a Ruby
# library to help them use the Observer pattern in tactical
# software. Here's how they'd like it to work: given a class =Dradis=
# which includes the module =Eventful=, they'd like to be able to
# declare an =#event= named =:new_contact=. They should then be able to
# instantiate an instance of the =Dradis= class and add listener objects
# by calling =#add_listener=. When they then call the =#new_contact=
# method, corresponding to the =:new_contact= event they declared
# earlier, every listener object should be sent the =#on_new_contact=
# message.


# #+name: dradis1

class Dradis
  include Eventful

  event :new_contact
end

# #+name: demo

class ConsoleListener
  def on_new_contact(direction, range)
    puts "DRADIS contact! #{range} kilometers, bearing #{direction}"
  end
end

dradis = Dradis.new
dradis.add_listener(ConsoleListener.new)
dradis.new_contact(120, 23000)

# Our first crack at the library looks like this. We define the
# =Eventful= module. We define the =included= callback to extend the
# including class with another module called =Macros=, which we'll
# define momentarily. We give the =Eventful= module a method for adding
# listeners. We also give it a method to notify all listeners of a given
# event.

# Now we turn our attention to the =Macros= module. This module contains
# the =event= macro, which uses =module_eval= to define a new instance
# method named for the given event. This method simply sends the
# =notify_listeners= message we defined earlier.

# #+name: eventful1

module Eventful
  def self.included(other)
    other.extend(Macros)
  end

  def add_listener(listener)
    (@listeners ||= []) << listener
  end

  def notify_listeners(event, *args)
    (@listeners || []).each do |listener|
      listener.public_send("on_#{event}", *args)
    end
  end

  module Macros
    def event(name)
      module_eval(%Q{
        def #{name}(*args)
          notify_listeners(:#{name}, *args)
        end
      })
    end
  end
end

module Eventful
  def self.included(other)
    other.extend(Macros)
  end

  def add_listener(listener)
    (@listeners ||= []) << listener
  end

  def notify_listeners(event, *args)
    (@listeners || []).each do |listener|
      listener.public_send("on_#{event}", *args)
    end
  end

  module Macros
    def event(name)
      module_eval(%Q{
        def #{name}(*args)
          notify_listeners(:#{name}, *args)
        end
      })
    end
  end
end
class Dradis
  include Eventful

  event :new_contact
end
class ConsoleListener
  def on_new_contact(direction, range)
    puts "DRADIS contact! #{range} kilometers, bearing #{direction}"
  end
end

dradis = Dradis.new
dradis.add_listener(ConsoleListener.new)
dradis.new_contact(120, 23000)

# #+RESULTS:
# : DRADIS contact! 23000 kilometers, bearing 120

# A quick note on terminology: Ruby doesn't have macros in the sense
# that Lisp and C do. Nonetheless, it's common to refer to class-level
# methods that generate other methods, modules, or classes as
# "macros". Don't let the term fool you, however: there's nothing
# special about these methods. They are just ordinary Ruby methods that
# happen to generate code.

# Getting back to our story: Fleet command accepts this library and at
# first it works well. But one day a consultant, we'll call him
# "Dr. Baltar", reports a problem. Baltar was trying to add a count of
# the total number of new contacts reported to the =Dradis= class. At
# first, he tried an implementation that looked like this:

# #+name: dradis2

class Dradis
  include Eventful

  event :new_contact

  attr_reader :contact_count

  def initialize
    @contact_count = 0
  end

  def new_contact(*args)
    @contact_count += 1
    new_contact(*args)
  end
end

# ...but of course this didn't work, because the method calls itself,
# this creating an infinite recursion and overflowing the stack.

# Next up, he tried aliasing the =new_contact= method that =Eventful=
# generates to another name, and then calling the original version from
# within the new version of the method.

# #+name: dradis3

class Dradis
  include Eventful

  event :new_contact

  attr_reader :contact_count

  def initialize
    @contact_count = 0
  end

  alias_method :new_contact_without_count, :new_contact
  def new_contact(*args)
    @contact_count += 1
    new_contact_without_count(*args)
  end
end

# #+name: demo2

class ConsoleListener
  def on_new_contact(direction, range)
    puts "DRADIS contact! #{range} kilometers, bearing #{direction}"
  end
end

dradis = Dradis.new
dradis.add_listener(ConsoleListener.new)
dradis.new_contact(120, 23000)
dradis.new_contact(250, 42000)
puts "Contact count: #{dradis.contact_count}"

module Eventful
  def self.included(other)
    other.extend(Macros)
  end

  def add_listener(listener)
    (@listeners ||= []) << listener
  end

  def notify_listeners(event, *args)
    (@listeners || []).each do |listener|
      listener.public_send("on_#{event}", *args)
    end
  end

  module Macros
    def event(name)
      module_eval(%Q{
        def #{name}(*args)
          notify_listeners(:#{name}, *args)
        end
      })
    end
  end
end
class Dradis
  include Eventful

  event :new_contact

  attr_reader :contact_count

  def initialize
    @contact_count = 0
  end

  alias_method :new_contact_without_count, :new_contact
  def new_contact(*args)
    @contact_count += 1
    new_contact_without_count(*args)
  end
end
class ConsoleListener
  def on_new_contact(direction, range)
    puts "DRADIS contact! #{range} kilometers, bearing #{direction}"
  end
end

dradis = Dradis.new
dradis.add_listener(ConsoleListener.new)
dradis.new_contact(120, 23000)
dradis.new_contact(250, 42000)
puts "Contact count: #{dradis.contact_count}"

# #+RESULTS:
# : DRADIS contact 23000 kilometers, bearing 120
# : DRADIS contact 42000 kilometers, bearing 250
# : Contact count: 2

# This worked, but he found it awfully verbose for such a simple
# change. He noted that this solution would make sense if he still
# needed access to the non-counted version of the method in other
# contexts; but that in this case it was just extra noise in the class's
# method list. Finally, he pointed out that this version was sensitive
# to how statements were ordered in the class definition: if the event
# was declared at the end of the class instead of at the beginning, it
# no longer worked.

# He tried one more approach. In this one, he saved a reference to the
# original version of the =#new_contact= method in a local variable
# inside the class definition. Then he used =define_method= to define
# the counted version of the method, calling the method object he'd
# saved earlier in order to trigger the original behavior.

class Dradis
  include Eventful

  event :new_contact

  def initialize
    @contact_count = 0
  end

  original_new_contact = instance_method(:new_contact)
  define_method(:new_contact) do |*args|
    @contact_count += 1
    original_new_contact.bind(self).call(*args)
  end
end

# Baltar's only comment on this version was that it was absurdly
# complicated, and we had to agree with him.

# We think about the problem for a while, and then we set about
# rewriting our little library. In the new version, we change the
# =#event= macro to first create a blank anonymous module. Then it
# generates the new event method within the context of that
# module. Finally, it includes the new module into the current class.

# #+name: eventful2

module Eventful
  def self.included(other)
    other.extend(Macros)
  end

  def add_listener(listener)
    (@listeners ||= []) << listener
  end

  def notify_listeners(event, *args)
    (@listeners || []).each do |listener|
      listener.public_send("on_#{event}", *args)
    end
  end

  module Macros
    def event(name)
      mod = Module.new
      mod.module_eval(%Q{
        def #{name}(*args)
          notify_listeners(:#{name}, *args)
        end
      })
      include mod
    end
  end
end

# By inserting the generated method into the class's ancestor chain,
# we've now made it possible for Dr. Baltar to implement his addition to
# the =#new_contact= method by simply redefining it, incrementing the
# call count, and then using =super= to defer to the original version of
# the method.

# #+name: dradis4

class Dradis
  include Eventful

  event :new_contact

  attr_reader :contact_count

  def initialize
    @contact_count = 0
  end

  def new_contact(*)
    @contact_count += 1
    super
  end
end

module Eventful
  def self.included(other)
    other.extend(Macros)
  end

  def add_listener(listener)
    (@listeners ||= []) << listener
  end

  def notify_listeners(event, *args)
    (@listeners || []).each do |listener|
      listener.public_send("on_#{event}", *args)
    end
  end

  module Macros
    def event(name)
      mod = Module.new
      mod.module_eval(%Q{
        def #{name}(*args)
          notify_listeners(:#{name}, *args)
        end
      })
      include mod
    end
  end
end
class Dradis
  include Eventful

  event :new_contact

  attr_reader :contact_count

  def initialize
    @contact_count = 0
  end

  def new_contact(*)
    @contact_count += 1
    super
  end
end
class ConsoleListener
  def on_new_contact(direction, range)
    puts "DRADIS contact! #{range} kilometers, bearing #{direction}"
  end
end

dradis = Dradis.new
dradis.add_listener(ConsoleListener.new)
dradis.new_contact(120, 23000)
dradis.new_contact(250, 42000)
puts "Contact count: #{dradis.contact_count}"

