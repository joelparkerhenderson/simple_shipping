module SimpleShipping
  class Abstract::Builder
    class_attribute :default_opts

    def self.build(model, opts = {})
      raise(ValidationError.new(model)) unless model.valid?

      builder = self.new(model, opts)
      builder.validate
      builder.build
    end

    def self.set_default_opts(opts = {})
      self.default_opts = opts
    end

    def initialize(model, opts)
      self.default_opts ||= {}
      @opts  = default_opts.merge(opts)
      @model = model
    end

    def build; {}; end
    def validate; end


    private

    def validate_inclusion_of(option, enumeration)
      unless enumeration.has_key?(@opts[option])
	raise ValidationError.new("#{option} has an unavailable value(#{@opts[option]}). Available values are #{enumeration.keys.inspect}") 
      end
    end
  end
end
