require_relative 'modules/instance_counter'
require_relative 'modules/validation'
require_relative 'modules/accessors'

class Station
  include InstanceCounter
  include Validation
  extend Accessors

  attr_reader :trains

  attr_accessor_with_history :name

  validate :name, :presence
  validate :name, :format, /[а-яa-z]{4}+/i
  validate :name, :type, String

  def initialize(name)
    @name = name && name.capitalize
    validate!
    @trains = []
    self.class.all << self
    register_instance
  end

  class << self
    def all
      @all ||= []
    end
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
    trains.select { |train| train.instance_of?(kind) }
  end

  def each_trains
    trains.each.with_index(1) { |train, index| yield(train, index) }
  end

  # protected

  # def validate!
  #   raise "Название не может быть пустым" if name.empty?
  #   raise "Название должно содержать минимум 4 символа" if name.size < 4
  # end
end
