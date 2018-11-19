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
    output(
      "Выберите действие:\n" \
      "1. Показать поезда\n" \
      "2. Создать поезд\n" \
      "3. Прицепить вагон к поезду\n" \
      "4. Отцепить вагон от поезда\n" \
      "5. Назначить маршрут\n" \
      "6. Управлять\n" \
      "Для возврата в главное меню нажмите любую другую клавишу"
    )
    input.to_i
  end

  def index
    trains = railway.trains

    if trains.any?
      output("Поезда:")
      trains.each.with_index(1) { |train, index| output("#{index}. #{train.info}") }
    else
      output("Поездов не создано")
    end

    delay
  end

  def create
    output("Создание поезда")

    loop do
      output("Введите номер поезда:")
      number = input

      output(
        "Выберите тип поезда:\n" \
        "1. Пассажирский\n" \
        "2. Грузовой"
      )
      kind = input.to_i - 1

      begin
        train = railway.create_train(number, kind)
        output("Поезд #{train.info} создан")
        break
      rescue RuntimeError => e
        output("Ошибка при создании поезда: #{e.message}")
      end
    end

    delay
  end

  def add_wagons
    output("Прицепление вагона к поеду")

    train = find_train_by_number

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

    train = find_train_by_number

    train.delete_wagon

    output("Вагон отцеплен")
  end

  def set_route
    output("Назначение маршрута поезду")

    train = find_train_by_number

    railway.routes.each.with_index(1) { |route, index| output("#{index}. #{route.info}") }

    output("Выберите маршрут:")
    selected = input.to_i - 1
    route = railway.find_route(selected)

    train.set_route(route)

    output("Маршрут назначен")
  end

  def drive
    output("Управление поездом")

    train = find_train_by_number

    output(
      "1. На следующую станцию\n" \
      "2. На предыдущую станцию"
    )
    selected = input.to_i

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

  private

  def find_train_by_number
    output("Введите номер поезда:")
    number = input
    railway.find_train(number)
  end
end
