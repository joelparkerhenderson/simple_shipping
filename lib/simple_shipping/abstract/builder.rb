module SimpleShipping
  # Kind of an abstract class which should be used to create model builders.
  # Model builder "knows" how to represent its model for a its service.
  # This class provides only common skeleton for subclasses.
  class Abstract::Builder
    class_attribute :default_opts

    # == Parameters:
    #   model - kind of {Abstract::Model}
    #   opts - hash of options. Every builder can have its own specific set of options
    # == Returns:
    #   Hash which can be used by Savon to build a part of SOAP request.
    def self.build(model, opts = {})
      raise(ValidationError.new(model)) unless model.valid?

      builder = self.new(model, opts)
      builder.validate
      builder.build
    end

    # Allows to set default option values is subclasses.
    def self.set_default_opts(opts = {})
      self.default_opts = opts
    end

    # Should be implemented by subclasses. But by default returns empty hash.
    def build; {}; end

    # Should be implemented by subclass if subclass needs to do some validation.
    def validate; end


    private

    def initialize(model = nil, opts = {})
      self.default_opts ||= {}
      @opts  = default_opts.merge(opts)
      @model = model
    end

    # Raises {ValidationError} if option has invalid value.
    def validate_inclusion_of(option, enumeration)
      unless enumeration.has_key?(@opts[option])
        raise ValidationError.new("#{option} has an unavailable value(#{@opts[option]}). Available values are #{enumeration.keys.inspect}") 
      end
    end

  end
end
