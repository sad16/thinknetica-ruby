class Train
  attr_reader :number, :kind, :speed
  attr_accessor :carriages_count, :route, :current_station

  def initialize(number, kind, carriages_count)
    @number = number.upcase
    @kind = kind.downcase
    @carriages_count = carriages_count > 0 ? carriages_count : 0
    @speed = 0
  end

  def current_speed
    speed
  end

  def speed_up(speed)
    self.speed += speed
  end

  def speed_down(speed)
    speed = self.speed < speed ? self.speed : speed
    self.speed -= speed
  end

  def brake
    self.speed = 0
  end

  def stop?
    speed.zero?
  end

  def add_carriage
    if stop?
      self.carriages_count += 1
    else
      { error: "Нельзя прицепить вагон - поезд движется" }
    end
  end

  def delete_carriage
    if stop?
      carriages_count.zero? ? { error: "Вагонов нет" } : self.carriages_count -= 1
    else
      { error: "Нельзя отцепить вагон - поезд движется" }
    end
  end

  def set_route(route)
    self.route = route
    self.current_station = self.route.from
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

  def go_next
    if next_station
      current_station.departure(self)
      self.current_station = next_station
      current_station.arrival(self)
    end
  end

  def go_prev
    if prev_station
      current_station.departure(self)
      self.current_station = prev_station
      current_station.arrival(self)
    end
  end
end
