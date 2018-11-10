require "./station"
require "./route"
require "./train"

stations = (1..10).map { |index| Station.new("Station-#{index}") }
route = Route.new(stations.first, stations.last)
passenger_train = Train.new("P1", "passenger", 12)

puts "set_route"
passenger_train.set_route(route)

puts "Поезд на станции: #{passenger_train.current_station.name}"
puts "Следующая станция: #{passenger_train.next_station.name}"

puts "go_next"
passenger_train.go_next

puts "Поезд на станции: #{passenger_train.current_station.name}"
puts "Предыдущая станция: #{passenger_train.prev_station.name}"

puts "go_prev"
passenger_train.go_prev

puts "Поезд на станции: #{passenger_train.current_station.name}"
puts "Следующая станция: #{passenger_train.next_station.name}"
