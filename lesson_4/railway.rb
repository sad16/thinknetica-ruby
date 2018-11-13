class Railway
  attr_reader :stations, :trains, :routes

  def initialize
    @stations = []
    @trains = []
    @routes = []
  end

  def create_station(name)
    station = Station.new(name)
    self.stations << station
    station
  end

  def find_station(index)
    stations[index]
  end

  def add_station(route, station)

  end

  def delete_station(route, station)

  end

  def create_train(number, kind)
    train = "#{train_kinds[kind].capitalize}".constantize.new(number)
    self.trains << train
    train
  end

  def find_train(index)
    trains[index]
  end

  def create_route(from, to)
    route = Routes.new(from, to)
    self.routes << route
    route
  end

  def find_route(index)
    routes[index]
  end

  def set_route(route, train)

  end

  def add_wagons(train, wagons_count)

  end

  def delete_wagons(train, wagons_count)

  end

  private

  attr_writer :stations, :trains, :routes

  def train_kinds
    ['passenger', 'cargo']
  end
end
