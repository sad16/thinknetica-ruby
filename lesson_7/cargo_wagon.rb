require_relative 'wagon'

class CargoWagon < Wagon
  attr_reader :volume, :occupied_volume

  def initialize(number, volume)
    super(number)
    @volume = volume && volume.to_f
    @occupied_volume = 0.0
    validate!
  end

  def info
    "#{number} | грузовой | Свободный объем: #{free_volume} | Занятый объем: #{occupied_volume}"
  end

  def occupy(volume)
    if has_free_volume?(volume)
      self.occupied_volume += volume
    else
      raise "Недостаточно свободного объема"
    end
  end

  def free_volume
    volume - occupied_volume
  end

  def has_free_volume?(volume)
    free_volume >= volume
  end

  protected

  def validate!
    super
    raise "Объем должен быть больше 0" unless volume.positive?
  end

  private

  attr_writer :occupied_volume
end
