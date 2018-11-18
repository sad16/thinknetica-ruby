require_relative 'modules/instance_counter'
require_relative 'modules/validation'

class Station
  include InstanceCounter
  include Validation

  attr_reader :name, :trains

  def initialize(name)
    @name = name && name.capitalize
    validate!
    @trains = []
    @@all << self
    register_instance
  end

  @@all = []

  def self.all
    @@all
  end

  def info
    name
  end

  def arrival(train)
    trains << train
  end

  def departure(train)
    trains.delete(train)
  end

  def trains_by_kind(kind)
    trains.select { |train| train.is_a?(kind) }
  end

  protected

  def validate!
    raise "Название не может быть пустым" if name.nil?
    raise "Название должно содержать минимум 4 символа" if name.size < 4
  end
end
