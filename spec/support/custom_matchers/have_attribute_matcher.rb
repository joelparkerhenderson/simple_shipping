module SimpleShipping
  module CustomMatchers
    class HaveAttributeMatcher < BasicMatcher
      def initialize(attribute)
	@attribute = attribute.to_sym
      end
      
      def matches?(model)
	model.respond_to?(@attribute) &&
	model.respond_to?("#{@attribute}=")
      end

      def description
	"have attribute #{@attribute.inspect}"
      end
    end

    def have_attribute(attr_name)
      HaveAttributeMatcher.new(attr_name)
    end
  end
end
