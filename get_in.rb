require 'httparty'

#  usage
#
#> ruby get_in.rb {day} {file}
#
# \/ \/ \/ paste your session cookie here \/ \/ \/
session_cookie="YOUR-COOKIE"

day = ARGV[0] || (Time.now+2*60*60).day.to_s
file = ARGV[1] || "day_#{day}_input"

url="https://adventofcode.com/2020/day/#{day}/input"
cookie_hash = HTTParty::CookieHash.new
cookie_hash.add_cookies("session" => session_cookie)
File.open(file, 'w') { |file| file.write(HTTParty.get(url, headers: {'Cookie' => cookie_hash.to_cookie_string }).chop)}
puts "Input Copied to: #{file}"