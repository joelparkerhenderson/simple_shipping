# Namespace for demo rake tasks used to test real remote requests by sending
# test requests to verify credentials. Not intended for runtime use.
class SimpleShipping::Demo
  extend ActiveSupport::Autoload

  autoload :Fedex
  autoload :Ups
  autoload :Base
end
