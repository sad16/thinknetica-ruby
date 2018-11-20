require_relative 'io_interface'

class StationInterface
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
          :station_trains
        end

      break unless action
      send(action)
    end
  end

  def menu
    output(
      "Выберите действие:\n" \
      "1. Показать станции\n" \
      "2. Создать станцию\n" \
      "3. Список поездов на станции\n" \
      "Для возврата в главное меню нажмите любую другую клавишу"
    )
    input.to_i
  end

  def index
    stations = railway.stations

    if stations.any?
      output("Станции:")
      stations.each.with_index(1) { |station, index| output("#{index}. #{station.info}") }
    else
      output("Станций не создано")
    end
    delay
  end

  def create
    output("Создание станции")

    output("Введите название:")
    name = input

    begin
      station = railway.create_station(name)
      output("Станция #{station.info} создана")
    rescue RuntimeError => error
      output("Ошибка: #{error.message}")
    end

    delay
  end

  def station_trains
    output("Список поездов на станции")

    output("Введите название:")
    name = input
    station = railway.find_station(name)

    if station
      if station.trains.any?
        output("Поезда на станции #{station.info}:")
        station.each_trains { |train, index| output("#{index}. #{train.info}") }
      else
        output("Поездов на станции #{station.info} нет")
      end
    else
      output("Станция #{name} не существует")
    end

    delay
  end
end
