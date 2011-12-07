module SimpleShipping
  # Parent error for all SimpleShipping errors
  class Error < Exception; end

  # Error raises when response does not contain a label
  class NoLabelError < Error ; end

  # Raises when some data is invalid or missing to build a request
  class ValidationError < Error
    def initialize(model_or_msg)
      @message = case model_or_msg
      when Abstract::Model
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
