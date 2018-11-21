require_relative 'train'

class PassengerTrain < Train
  def initialize(number)
    super(number)
  end

  def add_wagon(wagon)
    return unless wagon.instance_of?(PassengerWagon)
    super
  end
end
