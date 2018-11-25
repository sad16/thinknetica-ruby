module Accessors
  def attr_accessor_with_history(*names)
    names.each do |name|
      attr_reader_with_history(name)
      attr_writer_with_history(name)

      define_method("#{name}_history") do
        instance_variable_get("@#{name}_history".to_sym) || instance_variable_set("@#{name}_history".to_sym, [])
      end
    end
  end

  def attr_reader_with_history(*names)
    names.each do |name|
      define_method(name) { instance_variable_get("@#{name}".to_sym) }
    end
  end

  def attr_writer_with_history(*names)
    names.each do |name|
      define_method("#{name}=".to_sym) do |value|
        current_value = instance_variable_get("@#{name}".to_sym)
        send("#{name}_history".to_sym) << current_value unless current_value == value

        instance_variable_set("@#{name}".to_sym, value)
      end
    end
  end

  def strong_attr_accessor(name, type)
    strong_attr_reader(name)
    strong_attr_writer(name, type)
  end

  def strong_attr_reader(name)
    define_method(name) { instance_variable_get("@#{name}".to_sym) }
  end

  def strong_attr_writer(name, type)
    define_method("#{name}=".to_sym) do |value|
      raise "Типы не совпадают" unless value.class == type

      instance_variable_set("@#{name}".to_sym, value)
    end
  end
end
