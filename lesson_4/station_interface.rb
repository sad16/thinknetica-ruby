require_relative 'ui'

class StationInterface
  include UI

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
          :delete
        end

      break unless action
      send(action)
    end
  end

  private

  def menu
    input(
      "Выберите действие:\n" \
      "1. Показать станции\n" \
      "2. Создать станцию\n" \
      "3. Удалить станцию\n" \
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
    station = Station.new(name)
    railway.stations << station
    output("Станция #{station.info} создана")
    delay
  end

  def delete
    output("Удаление станции")
    name = input("Введите название:")
    station = railway.stations.detect{ |station| station.name == name }
    if railway.stations.delete(station)
      output("Станция #{station.info} удалена")
    else
      output("Станция #{name} не существует")
    end
    delay
  end
end
