module Validation
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    def validate(name, type, value = nil)
      send("#{type}_validate".to_sym, name, value)
    end

    private

    def presence_validate(name, _value)
      define_method("#{name}_presence_validate") do
        instance_variable = instance_variable_get("@#{name}".to_sym)
        raise "Название не может быть пустым" if instance_variable.nil? || instance_variable.empty?
      end
    end

    def format_validate(name, value)
      define_method("#{name}_format_validate") do
        instance_variable = instance_variable_get("@#{name}".to_sym)
        raise "Название должно содержать минимум 4 символа" if instance_variable !~ value
      end
    end

    def type_validate(name, value)
      define_method("#{name}_type_validate") do
        instance_variable = instance_variable_get("@#{name}".to_sym)
        raise "Типы не совпадают" unless instance_variable.class == value
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
      types = %w(presence format type)
      instance_variables.each do |variable|
        variable_name = variable.to_s.delete("@")
        types.each do |type|
          method_name = "#{variable_name}_#{type}_validate".to_sym
          send(method_name) if respond_to?(method_name)
        end
      end
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
