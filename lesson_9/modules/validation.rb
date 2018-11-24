module Validation
  def valid?
    validate!
    true
  rescue RuntimeError
    false
  end

  protected

  def validate!
    raise NotImplementedError
  end
end
