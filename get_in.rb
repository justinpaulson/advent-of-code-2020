require 'httparty'

#  usage
#
#> ruby get_in.rb {day} {file}
#
# \/ \/ \/ paste your session cookie here \/ \/ \/
session_cookie="53616c7465645f5fc3bed99e46b166db7952730140fd2d8c4a922130f7e0a0750e80d439d437960567a4c4a35a9bc7b6"

day = ARGV[0] || (Time.now+2*60*60).day.to_s
file = ARGV[1] || "day_#{day}_input"

url="https://adventofcode.com/2020/day/#{day}/input"
cookie_hash = HTTParty::CookieHash.new
cookie_hash.add_cookies("session" => session_cookie)
File.open(file, 'w') { |file| file.write(HTTParty.get(url, headers: {'Cookie' => cookie_hash.to_cookie_string }).chomp)}
puts "Input Copied to: #{file}"
