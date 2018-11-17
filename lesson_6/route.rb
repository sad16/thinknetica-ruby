require_relative 'modules/instance_counter'

class Route
  include InstanceCounter

  attr_reader :stations

  def initialize(from, to)
    @stations = [from, to]
    register_instance
  end

  def info
    "#{from.name} - #{to.name}"
  end

  def from
    stations.first
  end

  def to
    stations.last
  end

  def add(point, station)
    point -= 1

    if between?(point)
      stations.insert(point, station)
    else
      raise "В маршрут можно добавлять только промежуточные станции"
    end
  end

  def delete(station)
    unless from?(station) || to?(station)
      stations.delete(station)
    else
      raise "Из маршрута можно убирать только промежуточные станции"
    end
  end

  private

  def between?(point)
    point.between?(0, stations.size)
  end

  def from?(station)
    station == from
  end

  def to?(station)
    station == to
  end
end
