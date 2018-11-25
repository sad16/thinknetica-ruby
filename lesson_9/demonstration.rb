require_relative 'station'
require_relative 'train'

s = Station.new("First")
puts s.inspect
s.name = "Second"
puts s.inspect

begin
  Station.new(nil)
rescue RuntimeError => error
  puts error.message
end

begin
  Station.new("")
rescue RuntimeError => error
  puts error.message
end

begin
  Station.new("F")
rescue RuntimeError => error
  puts error.message
end

begin
  Station.new(:first)
rescue RuntimeError => error
  puts error.message
end
