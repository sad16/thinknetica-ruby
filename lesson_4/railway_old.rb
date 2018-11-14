class Railway
  attr_reader :stations, :routes, :trains

  def initialize
    @stations = []
    @routes = []
    @trains = []
  end

  def create_station(name)
    station = Station.new(name)
    self.stations << station
  end

  def create_route(from, to)
    route = Route.new(from, to)
    self.routes << route
  end

  def create_train(number, kind)
    train = "#{kind.capitalize}Train".constantize.new(number)
    self.trains << train
  end

  private

  attr_writer :stations, :routes, :trains
end
