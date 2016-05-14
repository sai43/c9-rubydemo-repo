
# #+TITLE: Macros and Modules, Part 2
# #+SETUPFILE: ../defaults.org

# In the last episode, we learned how to make generated methods easy to
# extend by putting them into a module instead of adding them directly
# to a class.

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

# #+name: all1

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
dradis.new_contact(270, 45000)
dradis.new_contact(180, 23000)
dradis.contact_count            # => 2
# >> DRADIS contact! 45000 kilometers, bearing 270
# >> DRADIS contact! 23000 kilometers, bearing 180

# This works well, but there are aspects of it which aren't completely
# satisfactory. Let's look at the ancestor chain of that class:

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
puts Dradis.ancestors

# #+RESULTS:
# : Dradis
# : #<Module:0x000000031ec730>
# : Eventful
# : Object
# : Kernel
# : BasicObject

# That anonymous module in the chain is neither pretty nor
# self-explanatory. It just gets worse as we add more events.

# #+name: dradis2

class Dradis
  include Eventful

  event :new_contact
  event :radiation_warning
  event :tigh_is_drunk_again
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
  event :radiation_warning
  event :tigh_is_drunk_again
end

puts Dradis.ancestors

# #+RESULTS:
# : Dradis
# : #<Module:0x000000049c7990>
# : #<Module:0x000000049c7f30>
# : #<Module:0x000000049c84d0>
# : Eventful
# : Object
# : Kernel
# : BasicObject

# We can improve the situation by giving the generated module a
# meaningful =#to_s= method. This makes the ancestor listing more
# useful.

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

        def self.to_s
          'Event(#{name})'
        end
      })
      include mod
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
      mod = Module.new
      mod.module_eval(%Q{
        def #{name}(*args)
          notify_listeners(:#{name}, *args)
        end

        def self.to_s
          'Event(#{name})'
        end
      })
      include mod
    end
  end
end
class Dradis
  include Eventful

  event :new_contact
  event :radiation_warning
  event :tigh_is_drunk_again
end
  
puts Dradis.ancestors

# #+RESULTS:
# : Dradis
# : Event(tigh_is_drunk_again)
# : Event(radiation_warning)
# : Event(new_contact)
# : Eventful
# : Object
# : Kernel
# : BasicObject

# But we're still cluttering up the ancestor chain with an entry for
# every event we declare. This might not be a problem as far as
# functionality goes, but it feels messy.

# Let's take our cleanup to the next level. This time, instead of just
# creating a module, we first check to see if there is a constant named
# "Events" on the current class. We pass =false= to =#constant_defined?=
# in order to exclude ancestors from the search. If the constant is set,
# we use the module it points to. Otherwise, we set the constant to
# point to a new module. We define a =#to_s= method on the new module to
# list all of the methods defined inside it. Finally, we use this module
# as the home for our new event triggering method.

# The upshot of all this is that no matter how many events we declare,
# there will only ever be one =Events= module per class. And when we
# take a look at the ancestor chain, it's very clear what events are
# defined for this class.

# #+name: eventful3

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
      mod = if const_defined?(:Events, false)
              const_get(:Events)
            else
              new_mod = Module.new do
                def self.to_s
                  "Events(#{instance_methods(false).join(', ')})"
                end
              end
              const_set(:Events, new_mod)
            end
      mod.module_eval(%Q{
        def #{name}(*args)
          notify_listeners(:#{name}, *args)
        end
      })
      include mod
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
      mod = if const_defined?(:Events, false)
              const_get(:Events)
            else
              new_mod = Module.new do
                def self.to_s
                  "Events(#{instance_methods(false).join(', ')})"
                end
              end
              const_set(:Events, new_mod)
            end
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
  event :radiation_warning
  event :tigh_is_drunk_again
end
  
puts Dradis.ancestors

# #+RESULTS:
# : Dradis
# : Events(new_contact, radiation_warning, tigh_is_drunk_again)
# : Eventful
# : Object
# : Kernel
# : BasicObject

# One of the great benefits of a dynamic language like Ruby is that it
# is highly explorable. Anytime we can add affordances that maintain or
# improve that explorability without hurting functionality, it's worth
# doing. In this case, we've made the observable events defined on a
# class more explorable.

# But the improvement isn't strictly cosmetic either. As we saw in the
# =#to_s= method, it is now very easy to programatically introspect into
# the event methods defined on classes. We know exactly where to find
# them.

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
      mod = if const_defined?(:Events, false)
              const_get(:Events)
            else
              new_mod = Module.new do
                def self.to_s
                  "Events(#{instance_methods(false).join(', ')})"
                end
              end
              const_set(:Events, new_mod)
            end
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
  event :radiation_warning
  event :tigh_is_drunk_again
end
  
Dradis::Events.instance_methods(false).each do |event_trigger|
  puts event_trigger
end

