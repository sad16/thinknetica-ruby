require_relative "railway"
require_relative "railway_interface"
require_relative "station"
require_relative "route"
require_relative "train"
require_relative "passenger_train"
require_relative "cargo_train"
require_relative "wagon"
require_relative "passenger_wagon"
require_relative "cargo_wagon"

RailwayInterface.new(Railway.new).start
