# Namespace for the abstract classes that define common interface for all
# shipping providers.
module SimpleShipping::Abstract
  extend ActiveSupport::Autoload

  autoload :Response
  autoload :Model
  autoload :Builder
  autoload :Client
  autoload :Request
end
