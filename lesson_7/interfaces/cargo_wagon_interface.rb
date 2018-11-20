require_relative 'io_interface'

class CargoWagonInterface
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
          :occupy
        end

      break unless action
      send(action)
    end
  end

  def menu
    output(
      "Выберите действие:\n" \
      "1. Посмотреть грузовые вагоны\n" \
      "2. Создать грузовой вагон\n" \
      "3. Заполнить\n" \
      "Для возврата нажмите любую другую клавишу"
    )
    input.to_i
  end

  def index
    output("Грузовые вагоны:")
    railway.cargo_wagons.each { |cargo_wagon| puts cargo_wagon.info }
    delay
  end

  def create
    output("Создание грузового вагона")

    output("Введите номер:")
    number = input

    output("Введите объем:")
    volume = input

    begin
      cargo_wagon = railway.create_cargo_wagon(number, volume)
      output("Вагон #{cargo_wagon.info} создан")
    rescue RuntimeError => error
      output("Ошибка: #{error.message}")
    end
  end

  def occupy
    output("Заполнить")

    output("Введите номер вагона:")
    number = input

    cargo_wagon = railway.find_cargo_wagon(number)

    if cargo_wagon
      output("Введите объем:")
      volume = input.to_f
      begin
        cargo_wagon.occupy(volume)
        output("Успешно. Информация о вагоне: #{cargo_wagon.info}")
      rescue RuntimeError => error
        output("Ошибка: #{error.message}")
      end
    else
      output("Вагон не найден")
    end

    delay
  end
end
