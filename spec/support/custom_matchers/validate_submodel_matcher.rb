module SimpleShipping
  module CustomMatchers
    class ValidateSubmodelMatcher

      def initialize(attribute)
	@attribute = attribute.to_sym
      end
      
      def matches?(model)
        @model = model

        @model.send("#{@attribute}=", Class.new.new)
        return false unless has_error?

        submodel = @class.new
        submodel.stub!(:valid? => false)
        @model.send("#{@attribute}=", submodel)
        return false unless has_error?

        submodel.stub!(:valid? => true)
        @model.send("#{@attribute}=", submodel)
        !has_error?
      end

      def failure_message
	"expected to #{description}"
      end

      def negative_failure_message
	"expected to #{description}"
      end

      def as(klass)
        @class = klass
        self
      end

      def description
	"validate submodel #{@attribute.inspect} as instance of #{@class}"
      end

      private

      def has_error?
        @model.valid?
	!!@model.errors.messages[@attribute]
      end
    end

    def validate_submodel(attr_name)
      ValidateSubmodelMatcher.new(attr_name)
    end
  end
end
