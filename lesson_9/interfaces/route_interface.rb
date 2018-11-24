require_relative 'io_interface'

class RouteInterface
  include IOInterface

  attr_reader :railway

  def initialize(railway)
    @railway = railway
  end

  def start
    loop do
      action =
        case menu
        when 1 then :index
        when 2 then :create
        when 3 then :add_station
        when 4 then :delete_station
        end

      break unless action

      send(action)
    end
  end

  def menu
    output(
      "Выберите действие:\n" \
      "1. Показать маршруты\n" \
      "2. Создать маршрут\n" \
      "3. Добавить станцию в маршрут\n" \
      "4. Удалить станцию из маршрута\n" \
      "Для возврата в главное меню нажмите любую другую клавишу"
    )
    input.to_i
  end

  def index
    routes = railway.routes

    if routes.any?
      output("Маршруты:")
      routes.each.with_index(1) { |route, index| output("#{index}. #{route.info}") }
    else
      output("Маршрутов не создано")
    end

    delay
  end

  def create
    output("Создание маршрута")

    output("Введите название начальной станции:")
    from_name = input
    from = railway.find_station(from_name)
    unless from
      output("Станция #{from_name} не существует")
      delay
      return
    end

    output("Введите название конечной станции:")
    to_name = input
    to = railway.find_station(to_name)
    unless to
      output("Станция #{to_name} не существует")
      delay
      return
    end

    route = railway.create_route(from, to)

    output("Маршрут #{route.info} создан")

    delay
  end

  def add_station
    output("Добавление станции в маршрут")

    route = select_route

    output("Введите станцию:")
    name = input
    station = railway.find_station(name)

    output("Введите номер остановки:")
    point = input.to_i
    route.add(point, station)

    output("Станция #{station.info} добавлена в маршрут")
  end

  def delete_station
    output("Удаление станции из маршрута")

    route = select_route

    output("Станции маршрута:")
    route.stations.each.with_index(1) { |station, index| output("#{index}. #{station.info}") }

    output("Введите станцию:")
    name = input
    station = route.stations.detect { |s| s.name == name }
    route.delete(station)

    output("Станция #{station.info} удалена из маршрута")
  end

  private

  def select_route
    index
    output("Выберите маршрут:")
    selected = input.to_i - 1
    route = railway.find_route(selected)
    output("Выбран маршрут #{route.info}")
    route
  end
end
