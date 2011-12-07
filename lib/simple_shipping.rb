module SimpleShipping
  WSDL_DIR = File.expand_path("../../wsdl", __FILE__)
end


require 'active_support/core_ext/class'
require 'active_resource'
require 'active_model'
require 'savon'
require 'RMagick'

require 'ostruct'

require 'simple_shipping/exceptions'
require 'simple_shipping/abstract'

require 'simple_shipping/address'
require 'simple_shipping/contact'
require 'simple_shipping/package'
require 'simple_shipping/party'
require 'simple_shipping/shipment'

require 'simple_shipping/fedex'
require 'simple_shipping/ups'

require 'simple_shipping/doc_store/label'
