# module InstanceCounter
#   def self.included(base)
#     base.extend ClassMethods
#     base.send :include, InstanceMethods
#     base.class_variable_set(:@@instances, 0)
#   end

#   module ClassMethods
#     def instances
#       self.class_variable_get(:@@instances)
#     end
#   end

#   module InstanceMethods
#     protected

#     def register_instance
#       self.class.class_variable_set(:@@instances, self.class.instances + 1)
#     end
#   end
# end

module InstanceCounter
  def self.included(base)
    base.extend ClassMethods
    base.send :include, InstanceMethods
  end

  module ClassMethods
    attr_writer :instances

    def instances
      @instances ||= 0
    end

    # def instances
    #   @instances ||= []
    # end

    # def instances_count
    #   instances.count
    # end
  end

  module InstanceMethods
    protected

    def register_instance
      self.class.instances += 1
    end

    # def register_instance
    #   self.class.instances << self
    # end
  end
end
