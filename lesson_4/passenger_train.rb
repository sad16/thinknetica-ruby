class PassengerTrain < Train
  def add_wagon(wagon)
    return unless wagon.is_a?(PassengerWagon)
    super
  end
end
