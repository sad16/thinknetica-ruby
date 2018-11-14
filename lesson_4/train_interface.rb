require_relative 'io_interface'

class TrainInterface
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
          :add_wagons
        when 4
          :delete_wagons
        when 5
          :set_route
        when 6
          :drive
        end

      break unless action
      send(action)
    end
  end

  def menu
    input(
      "Выберите действие:\n" \
      "1. Показать поезда\n" \
      "2. Создать поезд\n" \
      "3. Прицепить вагон к поезду\n" \
      "4. Отцепить вагон от поезда\n" \
      "5. Назначить маршрут\n" \
      "6. Управлять\n" \
      "Для возврата в главное меню нажмите любую другую клавишу"
    ).to_i
  end

  def index
    trains = railway.trains

    if trains.any?
      output("Поезда:")
      trains.each_with_index { |train, index| output("#{index + 1}. #{train.info}") }
    else
      output("Поездов не создано")
    end

    delay
  end

  def create
    output("Создание поезда")

    number = input("Введите номер поезда:")
    kind = input(
      "Выберите тип поезда:\n" \
      "1. Пассажирский\n" \
      "2. Грузовой"
    ).to_i

    train = railway.create_train(number, kind - 1)

    output("Поезд #{train.info} создан")

    delay
  end

  def add_wagons
    output("Прицепление вагона к поеду")

    number = input("Введите номер поезда")
    train = railway.find_train(number)

    wagon = 
      if train.is_a?(PassengerTrain)
        PassengerWagon.new
      else
        CargoWagon.new
      end

    train.add_wagon(wagon)

    output("Вагон прицеплен")
  end

  def delete_wagons
    output("Отцепление вагона от поеда")

    number = input("Введите номер поезда")
    train = railway.find_train(number)

    train.delete_wagon

    output("Вагон отцеплен")
  end

  def set_route
    output("Назначение маршрута поезду")

    number = input("Введите номер поезда")
    train = railway.find_train(number)

    railway.routes.each_with_index { |route, index| output("#{index + 1}. #{route.info}") }
    index_selected = input("Выберите маршрут:").to_i
    route = railway.find_route(index_selected - 1)

    train.set_route(route)

    output("Маршрут назначен")
  end

  def drive
    output("Управление поездом")

    number = input("Введите номер поезда")
    train = railway.find_train(number)

    selected = input(
      "1. На следующую станцию\n" \
      "2. На предыдущую станцию"
    ).to_i

    case selected
    when 1
      output("Следующая станция: #{train.next_station.info}")
      train.go_next_station
    when 2
      output("Предыдущая станция: #{train.prev_station.info}")
      train.go_prev_station
    end

    output("Текущая станция поезда #{train.current_station.info}")
  end
end
