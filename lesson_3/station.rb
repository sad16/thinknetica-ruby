class Station
  attr_reader :name, :train_list

  def initialize(name)
    @name = name.capitalize
    @train_list = []
    puts "Создана станция #{@name}"
  end

  def arrival(train)
    puts "На станцию #{name} прибыл #{train.kind} поезд номер #{train.number}"
    train_list.push(train)
    train
  end

  def departure(train)
    puts "Со станции #{name} убыл #{train.kind} поезд номер #{train.number}"
    train_list.delete(train)
    train
  end

  def trains(kind = nil)
    trains =
      if kind
        train_list.select { |train| train.kind == kind }
      else
        train_list
      end

    if trains.any?
      puts "Поезда на станции #{name}:"
      trains.each { |train| train.info }
    else
      puts "В данный момент поездов на станции нет"
    end

    trains
  end
end
