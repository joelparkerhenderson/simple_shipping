#!/usr/bin/env ruby

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)

require 'rubygems'
require 'simple_shipping'
require 'simple_shipping/ups'
require 'RMagick'
require 'fileutils'
require 'forgery'
require 'yaml'

package_path_base = File.expand_path('../ups_certification_package/', __FILE__)
FileUtils.rm_rf(package_path_base) if File.directory?(package_path_base)

# YAML file with credentials
unless credentials_file = ARGV.pop
  abort "Usage:\n  #{$0} <PATH_TO_CREDENTIALS.yml>"
end

CREDENTIALS    = YAML.load_file(credentials_file )['ups'].symbolize_keys!
ACCOUNT_NUMBER = CREDENTIALS.delete(:account_number)

5.times do |iteration|
  package_path = File.join(package_path_base, iteration.to_s)
  FileUtils.mkdir_p(package_path)

  shipper_address = SimpleShipping::Address.new(
    :country_code => 'US',
    :state_code   => 'IL',
    :postal_code  => '60201',
    :city         => Forgery::Address.city,
    :street_line  => Forgery::Address.street_address
  )
  shipper_contact = SimpleShipping::Contact.new(
    :person_name  => Forgery::Name.full_name,
    :phone_number => Forgery::Address.phone
  )
  shipper = SimpleShipping::Party.new(
    :address        => shipper_address,
    :contact        => shipper_contact,
    :account_number => ACCOUNT_NUMBER
  )
  recipient_address = SimpleShipping::Address.new(
    :country_code => 'US',
    :state_code   => 'SC',
    :postal_code  => '29072',
    :city         => Forgery::Address.city,
    :street_line  => Forgery::Address.street_address
  )
  recipient_contact = SimpleShipping::Contact.new(
    :person_name  => Forgery::Name.full_name,
    :phone_number => Forgery::Address.phone
  )
  recipient = SimpleShipping::Party.new(
    :address => recipient_address,
    :contact => recipient_contact
  )
  package = SimpleShipping::Package.new(
    :weight         => 0.5,
    :packaging_type => :envelope,
    :insured_value  => iteration * 250.0,
    :declared_value => iteration * 250.0
  )

  confirm_path = File.join(package_path, "confirm")
  FileUtils.mkdir_p(confirm_path)

  confirm_client = SimpleShipping::Ups::ShipClient.new(
    :debug       => true,
    :debug_path  => confirm_path,
    :credentials => CREDENTIALS
  )

  puts "CONFIRM REQUEST #{iteration}"
  confirm = confirm_client.ship_confirm_request(shipper, recipient, package)

  accept_path = File.join(package_path, "accept")
  FileUtils.mkdir_p(accept_path)
  accept_client = SimpleShipping::Ups::ShipClient.new(
    :debug       => true,
    :debug_path  => accept_path,
    :credentials => CREDENTIALS
  )

  puts "ACCEPT REQUEST #{iteration}"
  accept = accept_client.ship_accept_request(confirm.digest)

  puts "SAVING LABEL HTML"
  File.open(File.join(package_path, "label.html"), "w") {|f| f.write accept.label_html}

  puts "SAVING LABEL GIF"
  image_name = "label#{accept.tracking_number}.gif"
  img        = Magick::Image.read_inline(accept.label_image_base64).first
  img.write(File.join(package_path, image_name))


  # Apparently, the HTML version is OK:
  # http://www.corecommerce.com/kb/328/ups_label_certification_requiring_39th_file
  if accept.receipt_html
    puts "SAVING HIGH VALUE REPORT HTML"
    File.open(File.join(package_path, "high_value_report.html"), "w") {|f| f.write accept.receipt_html}
  end
end

VOID_NUMBERS = [
  # A successful XML response will be returned for a shipment level void request.
  ['1ZISDE016691676846'],
  # ￼A successful XML response will be returned for a shipment level void request.
  ['1Z2220060290602143'],
  # A successful XML response will be returned for a package level void request. The request will void the package in the shipment.
  ['1Z2220060294314162', '1Z2220060291994175'],
  # A successful XML response will be returned for a package level void request. The request will void the package in the shipment. .
  ['1Z2220060292690189', '1Z2220060292002190'],

  # Multiple tracking numbers for each shipment identifier. These don't seem to
  # work, but implementing them is unnecessary.

  # ￼A successful XML response will be returned for a package level void request. The request will void all the packages.
  # ['1ZISDE016691609089', '1ZISDE016694068891'],
  # ￼A successful XML response will be returned for a package level void request. The request will void all the packages.
  # ['1ZISDE016691609089', '1ZISDE016690889305'],
  # ￼A successful XML response will be returned with a partial void for a package level void request. The request will void package 1Z2220060293874210 but package 1Z2220060292634221 cannot be voided.
  # ['1Z2220060290530202', '1Z2220060293874210'],
  # ￼A successful XML response will be returned with a partial void for a package level void request. The request will void package 1Z2220060293874210 but package 1Z2220060292634221 cannot be voided.
  # ['1Z2220060290530202', '1Z2220060292634221']
]

VOID_NUMBERS.each do |identifier, tracking_number|
  package_path = File.join(package_path_base, "void/#{identifier}")
  FileUtils.mkdir_p(package_path)

  void_client = SimpleShipping::Ups::VoidClient.new(
    :debug       => true,
    :debug_path  => package_path,
    :credentials => CREDENTIALS
  )
  puts "VOID REQUEST: #{identifier}"
  void_client.void_request(identifier, :tracking_number => tracking_number)
end
