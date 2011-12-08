class SimpleShipping::Abstract::Model
  include ActiveModel::Validations

  class_attribute :default_values

  def self.set_default_values(values = {})
    self.default_values = values 
  end

  def self.validates_submodel(name, opts = {})
    validate do
      klass = opts[:as] || raise(":as option should be passed")
      submodel = send(name)
      if !submodel.instance_of?(klass)
        errors.add(name.to_sym, "must be an instance of #{klass.inspect}") 
      elsif submodel.invalid?
        errors.add(name.to_sym, "is invalid")
      end
    end
  end

  def initialize(values = {})
    values.reverse_merge!(default_values || {})
    values.each do |attribute, value|
      raise("Undefined attribute `#{attribute}` for #{self}") unless respond_to?(attribute)
      send("#{attribute}=", value)
    end
  end
end
