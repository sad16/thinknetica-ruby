require_relative 'modules/instance_counter'

class Station
  include InstanceCounter

  attr_reader :name, :trains

  def initialize(name)
    @name = name.capitalize
    @trains = []
    register_instance
  end

  def self.all
    ObjectSpace.each_object(self).to_a
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
end
