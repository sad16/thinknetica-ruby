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
        when 1
          :index
        when 2
          :create
        when 3
          :add_station
        when 4
          :delete_station
        end

      break unless action
      send(action)
    end
  end

  def menu
    input(
      "Выберите действие:\n" \
      "1. Показать маршруты\n" \
      "2. Создать маршрут\n" \
      "3. Добавить станцию в маршрут\n" \
      "4. Удалить станцию из маршрута\n" \
      "Для возврата в главное меню нажмите любую другую клавишу"
    ).to_i
  end

  def index
    routes = railway.routes

    if routes.any?
      output("Маршруты:")
      routes.each_with_index { |route, index| output("#{index + 1}. #{route.info}") }
    else
      output("Маршрутов не создано")
    end

    delay
  end

  def create
    output("Создание маршрута")

    from_name = input("Введите название начальной станции:")
    from = railway.find_station(from_name)
    unless from
      output("Станция #{from_name} не существует")
      delay
      return
    end

    to_name = input("Введите название конечной станции:")
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

    index

    index_selected = input("Выберите маршрут:").to_i
    route = railway.find_route(index_selected - 1)

    output("Выбран маршрут #{route.info}")

    name = input("Введите станцию:")
    station = railway.find_station(name)

    point = input("Введите номер остановки:").to_i
    route.add(point, station)

    output("Станция #{station.info} добавлена в маршрут")
  end

  def delete_station
    output("Удаление станции из маршрута")

    index

    index_selected = input("Выберите маршрут:").to_i
    route = railway.find_route(index_selected - 1)

    output("Выбран маршрут #{route.info}")

    output("Станции маршрута:")
    route.stations.each_with_index { |station, index| output("#{index + 1}. #{station.info}") }

    name = input("Введите станцию:")
    station = route.stations.detect { |station| station.name == name }
    route.delete(station)

    output("Станция #{station.info} удалена из маршрута")
  end
end
