module SimpleShipping
  module CustomMatchers
    class HaveDefaultValueMatcher < BasicMatcher
      def initialize(value)
        @value = value
      end
      
      def matches?(model)
        model.send(@attribute) == @value
      end

      def for_attribute(attribute)
        @attribute = attribute.to_sym
        self
      end

      def description
        "have default value #{@value.inspect} for attribute #{@attribute.inspect}"
      end
    end

    def have_default_value(value)
      HaveDefaultValueMatcher.new(value)
    end
  end
end
