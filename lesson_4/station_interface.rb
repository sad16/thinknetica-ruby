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
    input(
      "Выберите действие:\n" \
      "1. Показать станции\n" \
      "2. Создать станцию\n" \
      "3. Список поездов на станции\n" \
      "Для возврата в главное меню нажмите любую другую клавишу"
    ).to_i
  end

  def index
    stations = railway.stations

    if stations.any?
      output("Станции:")
      stations.each_with_index { |station, index| output("#{index + 1}. #{station.info}") }
    else
      output("Станций не создано")
    end
    delay
  end

  def create
    output("Создание станции")

    name = input("Введите название:")
    station = railway.create_station(name)

    output("Станция #{station.info} создана")

    delay
  end

  def station_trains
    output("Список поездов на станции")

    name = input("Введите название:")
    station = railway.find_station(name)

    if station
      if station.trains.any?
        output("Поезда на станции #{station.info}:")
        station.trains.each_with_index { |train, index| output("#{index + 1}. #{train.info}") }
      else
        output("Поездов на станции #{station.info} нет")
      end
    else
      output("Станция #{name} не существует")
    end

    delay
  end
end
