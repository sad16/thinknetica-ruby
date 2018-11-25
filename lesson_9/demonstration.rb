require_relative 'station'
require_relative 'train'

s1 = Station.new("First")
puts s1.inspect
s1.name = "Second"
puts s1.inspect

puts "Station.new('')"
begin
  Station.new("")
rescue RuntimeError => error
  puts error.message
end

puts "Station.new('F)"
begin
  Station.new("F")
rescue RuntimeError => error
  puts error.message
end

puts "Station.new(:first)"
begin
  Station.new(:first)
rescue RuntimeError => error
  puts error.message
end
