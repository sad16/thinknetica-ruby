require_relative 'station_interface'
require_relative 'route_interface'
require_relative 'train_interface'
require_relative 'wagon_interface'
require_relative 'io_interface'

class RailwayInterface
  include IOInterface

  attr_reader :railway, :station_interface, :route_interface, :train_interface, :wagon_interface

  def initialize(railway)
    @railway = railway
    @station_interface = StationInterface.new(railway)
    @route_interface = RouteInterface.new(railway)
    @train_interface = TrainInterface.new(railway)
    @wagon_interface = WagonInterface.new(railway)
  end

  def start
    output("Программа-симулятор железной дороги")

    loop do
      object_interface =
        case menu
        when 1 then station_interface
        when 2 then route_interface
        when 3 then train_interface
        when 4 then wagon_interface
        end

      break unless object_interface

      object_interface.start
    end

    output("Работа программы завершена")
    exit
  end

  def menu
    output(
      "Выберите объект:\n" \
      "1. Станции\n" \
      "2. Маршруты\n" \
      "3. Поезда\n" \
      "4. Вагоны\n" \
      "Для завершения работы программы нажмите любую другую клавишу"
    )
    input.to_i
  end
end
