require 'rubygems'
require 'bundler'

Bundler.require

require 'wayback'


url = ARGV[0] rescue nil
raise "You need to pass a URL as the first argument." if url.nil?
time = ARGV[1] rescue nil
time ||= :first
time = time.to_sym if ['first', 'last'].include?(time)

# Lets get the list
lists = Wayback.list(url)
puts lists.inspect


# Lets get the latest
page = Wayback.page(url, time)
puts page.inspect
