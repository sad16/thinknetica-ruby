require './station'
require './route'
require './train'

def separator
  puts "==============="
end

first_station = Station.new("Первая")
last_station = Station.new("Последняя")
first_additional_station = Station.new("Дополнительная-1")
second_additional_station = Station.new("Дополнительная-2")
disabled_station = Station.new("Нерабочая")
separator

route = Route.new(first_station, last_station)
separator

passenger_train = Train.new("П1", "пассажирский", 12)
freight_train = Train.new("Г1", "грузовой", 24)
separator

route.stations
separator

route.add(1, first_additional_station)
route.add(3, first_additional_station)
route.add(2, first_additional_station)
route.add(3, second_additional_station)
separator

route.stations
separator

route.delete(first_station)
route.delete(last_station)
route.delete(first_additional_station)
route.delete(disabled_station)
separator

route.stations
separator

passenger_train.info
passenger_train.current_speed
separator

passenger_train.accelerate(60)
passenger_train.current_speed
passenger_train.add_carriage
passenger_train.delete_carriage
separator

passenger_train.brake
passenger_train.current_speed
passenger_train.add_carriage
passenger_train.delete_carriage
separator

passenger_train.set_route(route)
separator

freight_train.set_route(route)
separator

first_station.trains
separator

passenger_train.go_prev
separator

passenger_train.go_next
separator

passenger_train.go_next
separator

passenger_train.go_next
separator

passenger_train.go_prev
separator
