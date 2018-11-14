require_relative 'station_interface'
require_relative 'ui'

class RailwayInterface
  include UI

  def initialize(railway)
    @railway = railway
    @station_interface = StationInterface.new(railway)
  end

  def start
    output("Программа-симулятор железной дороги")

    loop do
      object_interface =
        case menu
        when 1
          station_interface
        when 2
          # route_interface
        when 3
          # train_interface
        end

      break unless object_interface
      object_interface.start
    end

    output("Работа программы завершена")
    exit
  end

  private

  attr_reader :railway, :station_interface

  def menu
    input(
      "Выберите объект:\n" \
      "1. Станции\n" \
      "2. Маршруты\n" \
      "3. Поезда\n" \
      "Для завершения работы программы нажмите любую другую клавишу"
    ).to_i
  end

  # def show_stations
  #   output("Список станций:")
  #   railway.stations.each_with_index { |station, index| output("#{index + 1}. #{station.info}") }
  # end

  # def show_trains
  #   output("Список поездов:")
  #   railway.trains.each_with_index { |train, index| output("#{index + 1}. #{train.info}") }
  # end

  # def show_routes
  #   output("Список маршрутов:")
  #   railway.routes.each_with_index { |route, index| output("#{index + 1}. #{route.info}") }
  # end

  # def create_station
  #   output("Создание станции")
  #   name = input("Введите название:")
  #   station = railway.create_station(name)
  #   output("Станция #{station.info} создана")
  # end

  # def create_train
  #   output("Создание поезда")
  #   number = input("Введите номер:")
  #   kind = input(
  #     "Выберите тип:\n" \
  #     "1. Пассажирский\n" \
  #     "2. Грузовой"
  #   ).to_i
  #   train = railway.create_train(number, kind)
  #   output("Поезд #{train.info} создан")
  # end

  # def create_route
  #   output("Создание маршрута")
  #   show_stations
  #   from_index = input("Выберите начальную станцию:").to_i
  #   from = railway.find_station(from_index - 1)
  #   to_index = input("Выберите конечную станцию:").to_i
  #   to = railway.find_station(to_index - 1)
  #   route = railway.create_route(from, to)
  #   output("Маршрут #{route.info} создан")
  # end

  # def edit_route
  #   output("Изменение маршрута")
  #   show_routes
  #   route_index = input("Выберите маршрут:").to_i
  #   route = railway.find_route(route_index - 1)
  #   output("Выбран маршрут #{route.info}")
  #   action = input(
  #     "Выберите действие:\n" \
  #     "1. Добавить станцию\n" \
  #     "2. Удалить станцию"
  #   ).to_i
  #   case action
  #   when 1
  #     add_station(route)
  #   when 2
  #     delete_station(route)
  #   end
  # end

  # def set_route
  #   output("Назначение маршрута")
  #   show_routes
  #   route_index = input("Выберите маршрут:").to_i
  #   route = railway.find_route(route_index - 1)
  #   output("Выбран маршрут #{route.info}")
  #   show_trains
  #   train_index = input("Выберите поезд:").to_i
  #   train = railway.find_train(train_index - 1)
  #   output("Выбран поезд: #{train.info}")
  #   railway.set_route(route, train)
  #   output("Маршрут #{route.info} назначен поеду #{train}")
  # end

  # def add_wagons
  #   output("Прицепить вагоны")
  #   show_trains
  #   train_index = input("Выберите поезд:").to_i
  #   train = railway.find_train(train_index - 1)
  #   output("Выбран поезд: #{train.info}")
  #   wagons_count = input("Введите количество вагонов:").to_i
  #   railway.add_wagons(train, wagons_count)
  #   output("Вагоны прицеплены")
  # end

  # def delete_wagons
  #   output("Отцепить вагоны")
  #   show_trains
  #   train_index = input("Выберите поезд:").to_i
  #   train = railway.find_train(train_index - 1)
  #   output("Выбран поезд: #{train.info}")
  #   wagons_count = input("Введите количество вагонов:").to_i
  #   railway.delete_wagons(train, wagons_count)
  #   output("Вагоны отцеплены")
  # end

  # def drive_train
  #   output("Управление поездом")
  #   show_trains
  #   train_index = input("Выберите поезд:").to_i
  #   train = railway.find_train(train_index - 1)
  #   output("Выбран поезд: #{train.info}")
  #   # движение вперед
  #   # движение назад
  # end

  # def show_trains_station
  #   output("Просмотр списка поездов на станции")
  #   show_stations
  #   station_index = input("Выберите станцию:").to_i
  #   station = railway.find_station(station_index - 1)
  #   output("Список поездов на станции #{station.info}:")
  #   station.trains.each_with_index { |train, index| output("#{index + 1}. #{train.info}") }
  # end

  # private

  # def add_station(route)

  # end

  # def delete_station(route)

  # end
end
