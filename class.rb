#class

# class MyStuff
    
#     def initialize()
#         @tangerine = "And now a thousand years between"
#     end

#     attr_reader :tangerine
#     # attr_writer :tangerine
#     # attr_accessor :tangerine

#     def apple()
#         puts "I AM CLASSY APPLES!"
#     end

# end


#  thing = MyStuff.new()
#  thing.apple()
#  puts thing.tangerine


#----------------

 class Song

   def initialize(lyrics)
     @lyrics = lyrics
   end

  def sing_me_a_song()
    @lyrics.each {|line| puts line }
  end
  
 end

happy_bday = Song.new(["Happy birthday to you",
          "I don't want to get sued",
          "So I'll stop right there"])
happy_bday.sing_me_a_song

# bulls_on_parade = Song.new(["They rally around tha family",
#             "With pockets full of shells"])

 

# bulls_on_parade.sing_me_a_song()

#----------

