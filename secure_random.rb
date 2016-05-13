require "securerandom"

p SecureRandom.random_number      # => 0.6578788068017444
p SecureRandom.random_number(100) # => 99
#SecureRandom.random_number(1..6) # => ArgumentError: comparison of Fixnum wit...

# ~> ArgumentError
# ~> comparison of Fixnum with Range failed
# ~>
# ~> /home/avdi/.rubies/ruby-2.1.3/lib/ruby/2.1.0/securerandom.rb:210:in `<'
# ~> /home/avdi/.rubies/ruby-2.1.3/lib/ruby/2.1.0/securerandom.rb:210:in `ran...
# ~> xmptmp-in34708kR.rb:5:in `<main>'



signup_url = "http://example.com/signup?token="
token      = SecureRandom.hex(16)

p signup_url + token
# => "http://example.com/signup?token=2feef1979ddb8b64b123d1e5ca520a71"

p SecureRandom.base64(64)
# => "E12L2DCFvHe0tQr8eHKPSumQS+bsnj/lEFq3eeFx3jsrfXUBrPl4Gw6ouPC4X9+YEIWoCJ3...

p SecureRandom.urlsafe_base64(64)
# => "PQEb5eiTTCPD91xa-YZI-0acuKI4MtDP73uarP1SvqdAxxVwzSieFM_R3B6VsEJDLsBWFEc...

p SecureRandom.random_bytes(24)
# => "\x15\xE8\x9C\xDAN\xE2\xBD@\xAEt\x1A\"\xF6)\x9D\xD4\xA7\x81\xF0 c\x88\xC...

p SecureRandom.uuid               
# => "c0e5d67e-2ccc-4878-bc6c-f6e478e4b260"
