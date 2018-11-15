module Company
  def self.included(base)
    base.send :include, InstanceMethods
    base.instance_variable_set(:@company_name, nil)
  end

  module InstanceMethods
    attr_reader :company_name

    def set_company_name(name)
      self.company_name = name
    end

    protected

    attr_writer :company_name
  end
end
