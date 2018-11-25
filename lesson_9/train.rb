require_relative 'modules/instance_counter'
require_relative 'modules/company'
require_relative 'modules/validation'
require_relative 'modules/accessors'

class Train
  include InstanceCounter
  include Company
  include Validation
  extend Accessors

  NUMBER_PATTERN = /^[а-я0-9]{3}-?[а-я0-9]{2}$/i.freeze

  attr_reader :wagons, :route, :current_station

  strong_attr_accessor :number, String

  validate :number, presence: true,
                    format: NUMBER_PATTERN

  # or

  # validate :number, presence: true
  # validate :number, format: NUMBER_PATTERN

  def initialize(number)
    @number = number && number.upcase
    validate!
    @speed = 0
    @wagons = []
    self.class.all[@number] = self
    register_instance
  end

  class << self
    def all
      @all ||= {}
    end

    def find(number)
      all[number]
    end
  end

  def info
    "#{number} | #{instance_of?(PassengerTrain) ? 'пассажирский' : 'грузовой'} | " \
    "Количество вагонов: #{wagons.count}"
  end

  def current_speed
    speed
  end

  def speed_up(speed)
    self.speed += speed
  end

  def speed_down(speed)
    speed = current_speed < speed ? current_speed : speed
    self.speed -= speed
  end

  def brake
    self.speed = 0
  end

  def stop?
    current_speed.zero?
  end

  def add_wagon(wagon)
    wagons << wagon if stop?
  end

  def delete_wagon
    wagons.pop if stop? && wagons.any?
  end

  def appoint_route(route)
    self.route = route
    self.current_station = route.from
    current_station.arrival(self)
    current_station
  end

  def next_station
    return if current_station.nil? || current_station == route.to

    point = route.stations.index(current_station)
    route.stations[point + 1]
  end

  def prev_station
    return if current_station.nil? || current_station == route.from

    point = route.stations.index(current_station)
    route.stations[point - 1]
  end

  def go_next_station
    return unless next_station

    current_station.departure(self)
    self.current_station = next_station
    current_station.arrival(self)
  end

  def go_prev_station
    return unless prev_station

    current_station.departure(self)
    self.current_station = prev_station
    current_station.arrival(self)
  end

  def each_wagons
    wagons.each.with_index(1) { |wagon, index| yield(wagon, index) }
  end

  protected

  attr_accessor :speed
  attr_writer :wagons, :route, :current_station

  # def validate!
  #   raise "Номер не может быть пустым" if number.empty?
  #   raise "Номер имеет не правильный формат" if number !~ NUMBER_PATTERN
  # end
end
