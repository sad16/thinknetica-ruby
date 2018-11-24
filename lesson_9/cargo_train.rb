require_relative 'train'

class CargoTrain < Train
  def initialize(number)
    super(number)
  end

  def add_wagon(wagon)
    return unless wagon.instance_of?(CargoWagon)

    super
  end
end
