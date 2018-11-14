class Station
  attr_reader :name, :trains

  def initialize(name)
    @name = name.capitalize
    @trains = []
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
    trains.select { |train| train.kind == kind }
  end
end
