require_relative 'io_interface'
require_relative 'passenger_wagon_interface'
require_relative 'cargo_wagon_interface'

class WagonInterface
  include IOInterface

  attr_reader :railway, :passenger_wagon_interface, :cargo_wagon_interface

  def initialize(railway)
    @railway = railway
    @passenger_wagon_interface = PassengerWagonInterface.new(railway)
    @cargo_wagon_interface = CargoWagonInterface.new(railway)
  end

  def start
    loop do
      wagon_interface =
        case menu
        when 1 then passenger_wagon_interface
        when 2 then cargo_wagon_interface
        end

      break unless wagon_interface

      wagon_interface.start
    end
  end

  def menu
    output(
      "Выберите тип вагонов:\n" \
      "1. Пассажирские\n" \
      "2. Грузовые\n" \
      "Для возврата нажмите любую другую клавишу"
    )
    input.to_i
  end
end
