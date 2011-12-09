# Base class for all simple shipping models.
class SimpleShipping::Abstract::Model
  include ActiveModel::Validations

  # hash with default attribute values
  class_attribute :default_values

  # Defines default values of attributes which should be setted when model is created.
  def self.set_default_values(values = {})
    self.default_values = values 
  end

  # Adds validation callback to validate submodel. Submodel is a model 
  # which belongs to current model.
  # == Parameters:
  # * name - name of attribute which is submodel
  # * opts - hash with only on key :as. It should points to class of submodel.
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

  # Creates new model and sets default and passed values.
  def initialize(values = {})
    values.reverse_merge!(default_values || {})
    values.each do |attribute, value|
      raise("Undefined attribute `#{attribute}` for #{self}") unless respond_to?(attribute)
      send("#{attribute}=", value)
    end
  end
end
