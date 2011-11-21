module SimpleShipping
  class Error < Exception; end
  class NoLabelError < Error ; end

  class ValidationError < Error
    def initialize(model_or_msg)
      @message = case model_or_msg
	when Base::Model
	  "Invalid model #{model_or_msg.class}. Validation errors: #{model_or_msg.errors.full_messages.join(', ')}"
	when String
	  model_or_msg
      end
    end

    def message
      @message
    end
  end
end
