# Overriding methods

# You've already done this once when overriding initialize in the exercise where you created the Square class.

# Overriding in the context of classes involves defining a method in a subclass that is already defined in the superclass. This results in the method being overridden in the subclass, but doesn't in any way affect the method in the superclass.

# In the example below, we subclass Array to create MyArray and override Array#map. Run the tests to see that Array is unaffected by the change.

# Example Code:

class MyArray < Array 
  def map
    'in soviet russia...'
  end
end


# Array.new([1, 3]).map { |n| n + 1 } works normally returning [2, 4] 
# MyArray.new([1, 3]).map { |n| n + 1 } behaves differently, returning 'in soviet russia...' 

