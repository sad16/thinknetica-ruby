require_relative 'station_interface'
require_relative 'route_interface'
require_relative 'train_interface'
require_relative 'io_interface'

class RailwayInterface
  include IOInterface

  attr_reader :railway, :station_interface, :route_interface, :train_interface

  def initialize(railway)
    @railway = railway
    @station_interface = StationInterface.new(railway)
    @route_interface = RouteInterface.new(railway)
    @train_interface = TrainInterface.new(railway)
  end

  def start
    output("Программа-симулятор железной дороги")

    loop do
      object_interface =
        case menu
        when 1
          station_interface
        when 2
          route_interface
        when 3
          train_interface
        end

      break unless object_interface
      object_interface.start
    end

    output("Работа программы завершена")
    exit
  end

  def menu
    input(
      "Выберите объект:\n" \
      "1. Станции\n" \
      "2. Маршруты\n" \
      "3. Поезда\n" \
      "Для завершения работы программы нажмите любую другую клавишу"
    ).to_i
  end
end
