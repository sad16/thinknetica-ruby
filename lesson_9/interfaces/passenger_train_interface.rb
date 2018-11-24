require_relative 'io_interface'

class PassengerTrainInterface
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
        when 3 then :wagons
        when 4 then :add_wagons
        when 5 then :delete_wagons
        when 6 then :appoint_route
        when 7 then :drive
        end

      break unless action

      send(action)
    end
  end

  def menu
    output(
      "Выберите действие:\n" \
      "1. Показать пассажирские поезда\n" \
      "2. Создать пассажирский поезд\n" \
      "3. Посмотреть вагоны поезда\n" \
      "4. Прицепить вагон\n" \
      "5. Отцепить вагон\n" \
      "6. Назначить маршрут\n" \
      "7. Управлять\n" \
      "Для возврата в главное меню нажмите любую другую клавишу"
    )
    input.to_i
  end

  def index
    passenger_trains = railway.passenger_trains

    if passenger_trains.any?
      output("Пассажирские поезда:")
      passenger_trains.each.with_index(1) { |train, index| output("#{index}. #{train.info}") }
    else
      output("Пассажирских поездов не создано")
    end

    delay
  end

  def create
    output("Создание пассажирского поезда")

    output("Введите номер поезда:")
    number = input

    begin
      train = railway.create_passenger_train(number)
      output("Поезд #{train.info} создан")
    rescue RuntimeError => e
      output("Ошибка: #{e.message}")
    end

    delay
  end

  def wagons
    output("Просмотр вагонов поезда")

    passenger_train = find_passenger_train_by_number

    passenger_train.each_wagons { |wagon, index| output("#{index}. #{wagon.info}") }
  end

  def add_wagons
    output("Прицепление вагона")

    passenger_train = find_passenger_train_by_number
    passenger_wagon = find_passenger_wagon_by_number

    passenger_train.add_wagon(passenger_wagon)

    output("Вагон прицеплен")
  end

  def delete_wagons
    output("Отцепление вагона")

    passenger_train = find_passenger_train_by_number

    passenger_train.delete_wagon

    output("Вагон отцеплен")
  end

  def appoint_route
    output("Назначение маршрута поезду")

    passenger_train = find_passenger_train_by_number

    railway.routes.each.with_index(1) { |route, index| output("#{index}. #{route.info}") }

    output("Выберите маршрут:")
    selected = input.to_i - 1
    route = railway.find_route(selected)

    passenger_train.appoint_route(route)

    output("Маршрут назначен")
  end

  def drive
    output("Управление поездом")

    passenger_train = find_passenger_train_by_number

    output(
      "1. На следующую станцию\n" \
      "2. На предыдущую станцию"
    )
    selected = input.to_i

    case selected
    when 1
      output("Следующая станция: #{passenger_train.next_station.info}")
      passenger_train.go_next_station
    when 2
      output("Предыдущая станция: #{passenger_train.prev_station.info}")
      passenger_train.go_prev_station
    end

    output("Текущая станция поезда #{passenger_train.current_station.info}")
  end

  private

  def find_passenger_train_by_number
    output("Введите номер поезда:")
    number = input
    railway.find_passenger_train(number)
  end

  def find_passenger_wagon_by_number
    output("Введите номер вагона:")
    number = input
    railway.find_passenger_wagon(number)
  end
end
