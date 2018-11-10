class Route
  attr_reader :station_list

  def initialize(from, to)
    @station_list = [from, to]
    puts "Создан маршрут #{from.name} - #{to.name}"
  end

  def from
    station_list.first
  end

  def to
    station_list.last
  end

  def stations
    puts "Станции маршрута:"
    station_list.each { |station| puts station.name }
    station_list
  end

  def add(point, station)
    point -= 1
    if beetwen?(point)
      puts "Станция #{station.name} добавлена в маршрут остановкой номер #{point}"
      station_list.insert(point, station)
    else
      puts "В маршрут можно добавлять только промежуточные станции"
    end
  end

  def delete(station)
    point = station_list.index(station)

    unless point
      puts "В маршруте нет станции #{station.name}"
      return
    end

    unless from?(point) || to?(point)
      puts "Станция #{station.name} убрана из маршрута"
      station_list.delete(station)
    else
      puts "Из маршрута можно убирать только промежуточные станции"
    end
  end

  private

  def beetwen?(point)
    (point > 0) && (point < station_list.size)
  end

  def from?(point)
    station_list[point] == from
  end

  def to?(point)
    station_list[point] == to
  end
end
