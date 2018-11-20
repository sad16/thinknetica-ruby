require_relative 'modules/company'
require_relative 'modules/validation'

class Wagon
  include Company
  include Validation

  attr_reader :number, :kind

  def initialize(number)
    @number = number
  end

  def info
    raise NotImplementedError
  end

  protected

  def validate!
    raise "Номер не может быть пустым" if number.empty?
  end
end
