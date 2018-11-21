require_relative 'wagon'

class PassengerWagon < Wagon
  attr_reader :seats, :busy_seats

  def initialize(number, seats)
    super(number)
    @seats = seats && seats.to_i
    @busy_seats = 0
    validate!
  end

  def info
    "#{number} | пассажирский | Количество свободных мест: #{free_seats} | Количество занятых мест: #{busy_seats}"
  end

  def busy_seat
    if free_seats?
      self.busy_seats += 1
    else
      raise "Все места заняты"
    end
  end

  def free_seats
    seats - busy_seats
  end

  def free_seats?
    free_seats.positive?
  end

  protected

  def validate!
    super
    raise "Количество мест должно быть больше 0" unless seats.positive?
  end

  private

  attr_writer :busy_seats
end
