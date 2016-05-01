#Modules serve two purposes:

#First they act as namespace, letting you define methods whose names will not clash with those defined elsewhere. 
#The examples mytrig.rb, mymoral.rb, usemodule.rb illustrates this.

#Second, they allow you to share functionality between classes - if a class mixes in a module, that module's 
#instance methods become available as if they had been defined in the class. They get mixed in.
#The program mixins.rb illustrates this.

require_relative 'mytrig'  
require_relative 'mymoral'  
Trig.sin(Trig::PI/4)  
Moral.sin(Moral::VERY_BAD) 
