class SimpleShipping::Base::Model
  include ActiveModel::Validations

  class_attribute :default_values

  def self.set_default_values(values = {})
    self.default_values = values 
  end
	
  def initialize(values = {})
    values.reverse_merge!(default_values || {})
    values.each do |attribute, value|
      raise("Undefined attribute `#{attribute}` for #{self}") unless respond_to?(attribute)
      send("#{attribute}=", value)
    end
  end
end
