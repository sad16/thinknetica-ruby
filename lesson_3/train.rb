class Train
  attr_reader :number, :kind
  attr_accessor :speed, :carriages_count,
                :route, :current_station

  def initialize(number, kind, carriages_count)
    @number = number.upcase
    @kind = kind.downcase
    @carriages_count = carriages_count
    @speed = 0
    @route = nil
    @current_station = nil
    puts "Создан #{@kind} поезд номер #{@number} с количеством вагонов равным #{carriages_count}"
  end

  def info
    info = "#{kind.capitalize} поезд номер #{number} с количеством вагонов равным #{carriages_count}"
    puts info
    info
  end

  def current_speed
    puts "Скорость поезда: #{speed}"
    speed
  end

  def accelerate(speed = 100)
    puts "Разгон поезда до: #{speed}"
    self.speed = speed
  end

  def brake(speed = 0)
    puts "Торможение поезда до: #{speed}"
    self.speed = speed
  end

  def stop?
    speed == 0
  end

  def add_carriage
    if stop?
      puts "Вагон прицеплен"
      self.carriages_count += 1
    else
      puts "Нельзя прицепить вагон - поезд движется"
    end
  end

  def delete_carriage
    if stop?
      if self.carriages_count != 0
        puts "Вагон отцеплен"
        self.carriages_count -= 1
      else
        puts "Вагонов нет"
      end
    else
      puts "Нельзя отцепить вагон - поезд движется"
    end
  end

  def set_route(route)
    self.route = route
    puts "Поезду назначен маршрут #{self.route.from.name} - #{self.route.to.name}"
    self.current_station = self.route.from
    self.current_station.arrival(self)
    self.route
  end

  def next_station
    if current_station == route.to
      puts "Поезд находится на конечной станции"
      return
    end

    point = route.station_list.index(current_station)
    next_station = route.station_list[point + 1]
    puts "Следующая станция: #{next_station.name}"
    next_station
  end

  def prev_station
    if current_station == route.from
      puts "Поезд находится на начальной станции"
      return
    end

    point = route.station_list.index(current_station)
    prev_station = route.station_list[point - 1]
    puts "Предыдущая станция: #{prev_station.name}"
    prev_station
  end

  def go_next
    if next_station
      self.current_station.departure(self)
      self.current_station = next_station
      self.current_station.arrival(self)
    end
  end

  def go_prev
    if prev_station
      self.current_station.departure(self)
      self.current_station = prev_station
      self.current_station.arrival(self)
    end
  end
end
