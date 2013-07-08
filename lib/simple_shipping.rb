require 'active_support/core_ext'
require 'active_model'
require 'savon'
require 'ostruct'


module SimpleShipping
  extend ActiveSupport::Autoload

  WSDL_DIR = File.expand_path("../../wsdl", __FILE__)

  autoload :Abstract
  autoload :Address
  autoload :Contact
  autoload :Demo
  autoload :Package
  autoload :Party
  autoload :Shipment

  autoload :Ups
  autoload :Fedex
end


require 'simple_shipping/exceptions'
