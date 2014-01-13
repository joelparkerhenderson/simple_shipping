# Namespace for FedEx provider.
module SimpleShipping::Fedex
  extend ActiveSupport::Autoload

  autoload :Client
  autoload :Request
  autoload :Response
  autoload :ShipmentBuilder
  autoload :PackageBuilder
  autoload :PartyBuilder

  autoload :ShipmentRequest
  autoload :ShipmentResponse
end
