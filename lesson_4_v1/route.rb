class Route
  attr_reader :stations

  def initialize(from, to)
    @stations = [from, to]
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

    if beetwen?(point)
      stations.insert(point, station)
    else
      { error: "В маршрут можно добавлять только промежуточные станции" }
    end
  end

  def delete(station)
    unless from?(station) || to?(station)
      stations.delete(station)
    else
      { error: "Из маршрута можно убирать только промежуточные станции" }
    end
  end

  private

  def beetwen?(point)
    (point > 0) && (point < stations.size)
  end

  def from?(station)
    station == from
  end

  def to?(station)
    station == to
  end
end
