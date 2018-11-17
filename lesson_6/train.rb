require_relative 'modules/instance_counter'
require_relative 'modules/company'

class Train
  include InstanceCounter
  include Company

  attr_reader :number, :wagons, :route, :current_station

  def initialize(number)
    @number = number.upcase
    @speed = 0
    @wagons = []
    @@all[@number] = self
    register_instance
  end

  @@all = {}

  class << self
    def find(number)
      @@all[number]
    end
  end

  def info
    "#{number} | Маршрут #{route ? route.info : 'не назначен'}"
  end

  def current_speed
    speed
  end

  def speed_up(speed)
    self.speed += speed
  end

  def speed_down(speed)
    speed = current_speed < speed ? current_speed : speed
    self.speed -= speed
  end

  def brake
    self.speed = 0
  end

  def stop?
    current_speed.zero?
  end

  def add_wagon(wagon)
    self.wagons << wagon if stop?
  end

  def delete_wagon
    self.wagons.pop if stop? && wagons.any?
  end

  def set_route(route)
    self.route = route
    self.current_station = route.from
    current_station.arrival(self)
    current_station
  end

  def next_station
    return if current_station.nil? || current_station == route.to

    point = route.stations.index(current_station)
    route.stations[point + 1]
  end

  def prev_station
    return if current_station.nil? || current_station == route.from

    point = route.stations.index(current_station)
    route.stations[point - 1]
  end

  def go_next_station
    if next_station
      current_station.departure(self)
      self.current_station = next_station
      current_station.arrival(self)
    end
  end

  def go_prev_station
    if prev_station
      current_station.departure(self)
      self.current_station = prev_station
      current_station.arrival(self)
    end
  end

  protected
  # эти методы должны быть доступны в дочерних классах
  attr_accessor :speed
  attr_writer :wagons, :route, :current_station
end
