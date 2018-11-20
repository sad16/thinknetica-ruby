require_relative "../railway"
require_relative "../interfaces/wagon_interface"

railway = Railway.new

railway.create_passenger_wagon("ВП1", 2)
railway.create_passenger_wagon("ВП2", 4)

railway.create_cargo_wagon("ВГ1", 2.5)
railway.create_cargo_wagon("ВГ2", 5)

WagonInterface.new(railway).start
