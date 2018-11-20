require_relative 'train'

class PassengerTrain < Train
  def initialize(number)
    @kind = "пассажирский"
    super(number)
  end

  def add_wagon(wagon)
    return unless wagon.is_a?(PassengerWagon)
    super
  end
end
