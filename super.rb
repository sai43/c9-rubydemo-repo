
class Animal
  def move
    "I can move"
  end
end

class Bird < Animal
  def move
    super + " by flying"
  end
end

# Your code here
class Human < Animal
  def move
    super + " by walking"
  end
end

class Penguin < Bird
  def move
    "I can move by swimming"
  end
end

puts Animal.new.move
puts Bird.new.move

# STDOUT:

# I can move
# I can move by flying


# Super Powered

# A common use of inheritance is to have overridden methods in a subclass do something in addition to what the superclass method did, rather than something entirely different (like in previous examples). This allows us to re-use behaviour that exists in a superclass, then modify to suit the needs of the subclass.

# Most object oriented languages offer a mechanism by which an overridden method can be called by the overriding method. Ruby uses the super keyword to make this happen. Using super will call the same method, but as defined in the superclass and give you the result.

# In the following example, we define behaviour on the class Animal that describes how it moves. Now a Dolphin is an Animal that can move, but it also wants to talk about how it moves.

