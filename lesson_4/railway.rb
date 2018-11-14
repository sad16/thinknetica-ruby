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
    station
  end

  def find_station(name)
    stations.detect { |station| station.name == name }
  end

  def create_route(from, to)
    route = Route.new(from, to)
    self.routes << route
    route
  end

  def find_route(index)
    routes[index]
  end

  def create_train(number, kind)
    train = 
      if kind.zero?
        PassengerTrain.new(number)
      else
        CargoTrain.new(number)
      end
    self.trains << train
    train
  end

  def find_train(number)
    trains.detect { |train| train.number == number }
  end

  private

  attr_writer :stations, :routes, :trains
end
