module SimpleShipping
  module CustomMatchers
    class HaveErrorsOnMatcher

      def initialize(attribute)
	@attribute = attribute.to_sym
      end
      
      def matches?(model)
        model.valid?
	!!model.errors.messages[@attribute]
      end

      def failure_message
	"expected to have errors on #{@attribute.inspect}"
      end

      def negative_failure_message
	"expected to not have errors on #{@attribute.inspect}"
      end

      def description
	"have errors on #{@attribute.inspect}"
      end
    end

    def have_errors_on(attr_name)
      HaveErrorsOnMatcher.new(attr_name)
    end
  end
end
