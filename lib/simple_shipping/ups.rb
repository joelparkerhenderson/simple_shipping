module SimpleShipping::Ups; end

require 'simple_shipping/ups/client'
require 'simple_shipping/ups/ship_client'
require 'simple_shipping/ups/void_client'

require 'simple_shipping/ups/request'
require 'simple_shipping/ups/request/ship_confirm_request'
require 'simple_shipping/ups/request/ship_accept_request'
require 'simple_shipping/ups/request/shipment_request'
require 'simple_shipping/ups/request/void_request'

require 'simple_shipping/ups/response'
require 'simple_shipping/ups/response/ship_confirm_response'
require 'simple_shipping/ups/response/ship_accept_response'
require 'simple_shipping/ups/response/shipment_response'
require 'simple_shipping/ups/response/void_response'

require 'simple_shipping/ups/package_builder'
require 'simple_shipping/ups/party_builder'
require 'simple_shipping/ups/shipment_builder'
