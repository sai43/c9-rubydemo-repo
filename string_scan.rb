
# Supposing we have some documents and we want to comb through them,
# pulling out email addresses into a list. We've got a basic regular
# expression for matching email addresses. All we need to do is apply it
# to the text.

# Here's one way we could do it. We could start a loop. At each
# repetition, the loop checks for a match. If one is found, it adds the
# match to a list of addresses. Then it updates the text to be searched
# to include only the portion /after/ the last match, and repeats. When
# it runs out of matches, it ends.

text = <<END
Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Donec
hendrerit tempor bob@example.com tellus. Donec pretium posuere
tellus. Proin quam nisl, tincidunt et, mattis eget, convallis nec,
purus. Cum sociis natoque penatibus et magnis dis parturient montes,
nascetur sue@example.org ridiculus mus. Nulla posuere. Donec vitae
dolor. Nullam tristique contact@shiprise.net diam non turpis. Cras
placerat accumsan nulla. Nullam president@whitehouse.gov rutrum. Nam
vestibulum accumsan nisl.
END
EMAIL_PATTERN = /\S+@\S+/i

addresses = []
while(match = EMAIL_PATTERN.match(text))
  addresses << match[0]
  text = match.post_match
end
addresses
# => ["bob@example.com",
#     "sue@example.org",
#     "contact@shiprise.net",
#     "president@whitehouse.gov"]

# This works. But... and you knew this was coming... we can do
# better. Instead of building a loop, we can use the =#scan= method on
# =String=. This method finds every match for a given regular expression.

addresses = text.scan(EMAIL_PATTERN)
# => ["bob@example.com",
#     "sue@example.org",
#     "contact@shiprise.net",
#     "president@whitehouse.gov"]

# There's another way to call =#scan=. If we want to process text as it
# is found, rather than waiting for an array of matches to be completed,
# we can pass a block. The block will be called for each match, with the
# matched string as the block argument.

text.scan(EMAIL_PATTERN) do |address|
  puts address
end

# >> bob@example.com
# >> sue@example.org
# >> contact@shiprise.net
# >> president@whitehouse.gov

# And that's not all. =#scan= is also aware of regular expression
# groupings. We can change our regular expression to have a group for
# the email username, and a group for the host. When we run =#scan=, the
# block now receives multiple arguments, one for each group.

EMAIL_PATTERN = /(\S+)@(\S+)/i

text.scan(EMAIL_PATTERN) do |name, host|
  puts "Name: #{name}, host: #{host}"
end

# >> Name: bob, host: example.com
# >> Name: sue, host: example.org
# >> Name: contact, host: shiprise.net
# >> Name: president, host: whitehouse.gov
