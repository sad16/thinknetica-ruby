require_relative "../railway"
require_relative "../interfaces/route_interface"

RouteInterface.new(Railway.new).start
