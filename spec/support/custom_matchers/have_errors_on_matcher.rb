module SimpleShipping
  module CustomMatchers
    class HaveErrorsOnMatcher < BasicMatcher

      def initialize(attribute)
        @attribute = attribute.to_sym
      end
      
      def matches?(model)
        model.valid?
        !!model.errors.messages[@attribute]
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
