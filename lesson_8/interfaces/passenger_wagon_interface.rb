require_relative 'io_interface'

class PassengerWagonInterface
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
        when 3 then :busy_seat
        end

      break unless action

      send(action)
    end
  end

  def menu
    output(
      "Выберите действие:\n" \
      "1. Посмотреть пассажирские вагоны\n" \
      "2. Создать пассажирский вагон\n" \
      "3. Занять место\n" \
      "Для возврата нажмите любую другую клавишу"
    )
    input.to_i
  end

  def index
    passenger_wagons = railway.passenger_wagons

    if passenger_wagons.any?
      output("Пассажирские вагоны:")
      passenger_wagons.each { |passenger_wagon| puts passenger_wagon.info }
    else
      output("Пассажирских вагонов не создано")
    end

    delay
  end

  def create
    output("Создание пассажирского вагона")

    output("Введите номер:")
    number = input

    output("Введите количество мест:")
    seats = input

    begin
      passenger_wagon = railway.create_passenger_wagon(number, seats)
      output("Вагон #{passenger_wagon.info} создан")
    rescue RuntimeError => error
      output("Ошибка: #{error.message}")
    end

    delay
  end

  def busy_seat
    output("Занять место")

    output("Введите номер вагона:")
    number = input

    passenger_wagon = railway.find_passenger_wagon(number)

    if passenger_wagon
      begin
        passenger_wagon.busy_seat
        output("Успешно. Информация о вагоне: #{passenger_wagon.info}")
      rescue RuntimeError => error
        output("Ошибка: #{error.message}")
      end
    else
      output("Вагон не найден")
    end

    delay
  end
end
