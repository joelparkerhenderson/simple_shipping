module SimpleShipping::Ups
  extend ActiveSupport::Autoload

  autoload :Client
  autoload :ShipClient
  autoload :VoidClient

  autoload :Request
  autoload :Response
  autoload :PackageBuilder
  autoload :PartyBuilder
  autoload :SharedResponseAttributes
  autoload :ShipmentBuilder

  autoload :ShipConfirmResponse
  autoload :ShipAcceptResponse
  autoload :ShipmentResponse
  autoload :VoidResponse

  autoload :ShipConfirmRequest
  autoload :ShipAcceptRequest
  autoload :ShipmentRequest
  autoload :VoidRequest
end



