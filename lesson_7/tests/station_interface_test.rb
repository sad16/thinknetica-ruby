require_relative "../railway"
require_relative "../interfaces/station_interface"

StationInterface.new(Railway.new).start
