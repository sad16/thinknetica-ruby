require_relative "railway"
require_relative "interfaces/railway_interface"

RailwayInterface.new(Railway.new).start
