require './module_test.rb'
#require_relative  './module_test.rb'

module Modul2
  include Crypt

  def self.hello
    'hello'
  end
  
  def self.bye
     'bye'
  end
  
end
p Modul2.methods
p Modul2.hello
p Modul2.bye
p Modul2.rsa


