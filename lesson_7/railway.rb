require_relative 'station'
require_relative 'route'
require_relative 'passenger_train'
require_relative 'cargo_train'
require_relative 'passenger_wagon'
require_relative 'cargo_wagon'

class Railway
  attr_reader :stations, :routes, :trains, :wagons

  def initialize
    @stations = []
    @routes = []
    @trains = []
    @wagons = []
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

  # wagons

  def create_passenger_wagon(number, seats)
    passenger_wagon = PassengerWagon.new(number, seats)
    self.wagons << passenger_wagon
    passenger_wagon
  end

  def create_cargo_wagon(number, volume)
    cargo_wagon = CargoWagon.new(number, volume)
    self.wagons << cargo_wagon
    cargo_wagon
  end

  def passenger_wagons
    wagons.select { |wagon| wagon.is_a?(PassengerWagon) }
  end

  def cargo_wagons
    wagons.select { |wagon| wagon.is_a?(CargoWagon) }
  end

  def find_passenger_wagon(number)
    passenger_wagons.detect { |wagon| wagon.number == number }
  end

  def find_cargo_wagon(number)
    cargo_wagons.detect { |wagon| wagon.number == number }
  end

  private

  attr_writer :stations, :routes, :trains, :wagons
end
