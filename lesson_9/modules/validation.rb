module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validations
      @validations ||= {}
    end

    def validate(name, options = {})
      if validations[name]
        validations[name].merge!(options)
      else
        validations[name] = options
      end
    end
  end

  module InstanceMethods
    def valid?
      validate!
      true
    rescue RuntimeError
      false
    end

    protected

    def validate!
      self.class.validations.each do |name, options|
        options.each do |type, value|
          validate_method_name = "#{type}_validate!".to_sym
          send(validate_method_name, name, value)
        end
      end
    end

    def presence_validate!(name, value)
      return unless value

      instance_variable = instance_variable_get("@#{name}".to_sym)
      raise "#{name} не может быть пустым" if instance_variable.nil? || instance_variable.empty?
    end

    def format_validate!(name, value)
      instance_variable = instance_variable_get("@#{name}".to_sym)
      raise "#{name} имеет неверный формат" if instance_variable !~ value
    end

    def type_validate!(name, value)
      instance_variable = instance_variable_get("@#{name}".to_sym)
      raise "#{name} имеет неверный тип" unless instance_variable.class == value
    end
  end
end

# module Validation
#   def valid?
#     validate!
#     true
#   rescue RuntimeError
#     false
#   end

#   protected

#   def validate!
#     raise NotImplementedError
#   end
# end
