require_relative 'io_interface'
require_relative 'passenger_train_interface'
require_relative 'cargo_train_interface'

class TrainInterface
  include IOInterface

  attr_reader :railway, :passenger_train_interface, :cargo_train_interface

  def initialize(railway)
    @railway = railway
    @passenger_train_interface = PassengerTrainInterface.new(railway)
    @cargo_train_interface = CargoTrainInterface.new(railway)
  end

  def start
    loop do
      train_interface =
        case menu
        when 1
          passenger_train_interface
        when 2
          cargo_train_interface
        end

      break unless train_interface
      train_interface.start
    end
  end

  def menu
    output(
      "Выберите тип поездов:\n" \
      "1. Пассажирские\n" \
      "2. Грузовые\n" \
      "Для возврата нажмите любую другую клавишу"
    )
    input.to_i
  end
end
