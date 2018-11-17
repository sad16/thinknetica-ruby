require_relative 'modules/instance_counter'

class Station
  include InstanceCounter

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

  def valid?
    validate!
    true
  rescue
    false
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

  private

  def validate!
    raise "Название не может быть пустым" if name.nil?
    raise "Название должно содержать минимум 4 символа" if name.size < 4
  end
end
