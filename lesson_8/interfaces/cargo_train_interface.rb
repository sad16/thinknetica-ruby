require_relative 'io_interface'

class CargoTrainInterface
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
      "1. Показать грузовые поезда\n" \
      "2. Создать грузовой поезд\n" \
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
    cargo_trains = railway.cargo_trains

    if cargo_trains.any?
      output("Грузовые поезда:")
      cargo_trains.each.with_index(1) { |train, index| output("#{index}. #{train.info}") }
    else
      output("Груховых поездов не создано")
    end

    delay
  end

  def create
    output("Создание грузового поезда")

    output("Введите номер поезда:")
    number = input

    begin
      train = railway.create_cargo_train(number)
      output("Поезд #{train.info} создан")
    rescue RuntimeError => e
      output("Ошибка: #{e.message}")
    end

    delay
  end

  def wagons
    output("Просмотр вагонов поезда")

    cargo_train = find_cargo_train_by_number

    cargo_train.each_wagons { |wagon, index| output("#{index}. #{wagon.info}") }
  end

  def add_wagons
    output("Прицепление вагона")

    cargo_train = find_cargo_train_by_number
    cargo_wagon = find_cargo_wagon_by_number

    cargo_train.add_wagon(cargo_wagon)

    output("Вагон прицеплен")
  end

  def delete_wagons
    output("Отцепление вагона")

    cargo_train = find_cargo_train_by_number

    cargo_train.delete_wagon

    output("Вагон отцеплен")
  end

  def appoint_route
    output("Назначение маршрута поезду")

    cargo_train = find_cargo_train_by_number

    railway.routes.each.with_index(1) { |route, index| output("#{index}. #{route.info}") }

    output("Выберите маршрут:")
    selected = input.to_i - 1
    route = railway.find_route(selected)

    cargo_train.appoint_route(route)

    output("Маршрут назначен")
  end

  def drive
    output("Управление поездом")

    cargo_train = find_cargo_train_by_number

    output(
      "1. На следующую станцию\n" \
      "2. На предыдущую станцию"
    )
    selected = input.to_i

    case selected
    when 1
      output("Следующая станция: #{cargo_train.next_station.info}")
      cargo_train.go_next_station
    when 2
      output("Предыдущая станция: #{cargo_train.prev_station.info}")
      cargo_train.go_prev_station
    end

    output("Текущая станция поезда #{cargo_train.current_station.info}")
  end

  private

  def find_cargo_train_by_number
    output("Введите номер поезда:")
    number = input
    railway.find_cargo_train(number)
  end

  def find_cargo_wagon_by_number
    output("Введите номер вагона:")
    number = input
    railway.find_cargo_wagon(number)
  end
end
