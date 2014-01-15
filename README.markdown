# Simple Shipping

[![Build Status](https://travis-ci.org/TMXCredit/simple_shipping.png?branch=master)](https://travis-ci.org/TMXCredit/simple_shipping)

Provides a common simple API to build labels for the following shipping services:

* [FedEx](http://fedex.com)
* [UPS](https://www.ups.com/upsdeveloperkit)

## Installation

Add to `Gemfile`:

```
gem 'simple_shipping'
```

Run `bundle install`.

## Usage
```ruby
# Build shipper
shipper_address = SimpleShipping::Address.new(
  :country_code => 'US',
  :state_code   => 'TX',
  :city         => 'Texas',
  :street_line  => 'SN2000 Test Meter 8',
  :postal_code  => '73301'
)
shipper_contact = SimpleShipping::Contact.new(
  :person_name  => 'Mister Someone',
  :phone_number => '1234567890'
)
shipper = SimpleShipping::Party.new(
  :address => shipper_address,
  :contact => shipper_contact
)

# Build recipient
recipient_address = SimpleShipping::Address.new(
  :country_code => 'US',
  :state_code   => 'MN',
  :city         => 'Minneapolis',
  :street_line  => 'Nightmare Avenue 13',
  :postal_code  => '55411'
)
recipient_contact = SimpleShipping::Contact.new(
  :person_name  => "John Recipient Smith",
  :phone_number => "1234567890"
)
recipient = SimpleShipping::Party.new(
  :address        => recipient_address,
  :contact        => recipient_contact,
  # optional, but required if party is payor
  :account_number => ACCOUNT_NUMBER
)

package = SimpleShipping::Package.new(
  :weight          => 1,
  :length          => 2,
  :height          => 3,
  :dimension_units => :in,  # you can use :cm as well
  :weight_units    => :lb,  # you can use :kg as well
  :width           => 4,
  :packaging_type  => :your
)

# Create clients
fedex = SimpleShipping::Fedex::Client.new(
  :credentials => {
    :key            => KEY,
    :password       => PASSWORD,
    :account_number => ACCOUNT_NUMBER,
    :meter_number   => METER_NUMBER
})
ups = SimpleShipping::Ups::ShipClient.new(
  :credentials => {
    :username              => USERNAME,
    :password              => PASSWORD,
    :access_license_number => ACCESS_LICENSE_NUMBER
  }
)

# Do request
# Default payor is :shipper
ups_resp   = ups.shipment_request(shipper, recipient, package)
fedex_resp = fedex.request(shipper, recipient, package, :payor => :recipient)
```

## Specific extra options
You can customize the request using specific options for the service by passing an options hash:

### FedEx extra options
* *:dropoff_type* (see `SimpleShipping::Fedex::ShipmentBuilder::DROPOFF_TYPES` for available values)
* *:service_type* (see `SimpleShipping::Fedex::ShipmentBuilder::SERVICE_TYPES` for available values)

*Example:*
```ruby
fedex_client.request(shipper, recipient, package, :dropoff_type => :drop_box)
```

## UPS extra options
* *service_type* (see `SimpleShipping::Ups::ShipmentBuilder::SERVICE_TYPES` for available values)

*Example*
```ruby
ups_client.shipment_request(shipper, recipient, package, :service_type => :express)
```

## Requirements

You must have ImageMagick installed to run the demos.

### Linux
#### Gentoo

  emerge -pv imagemagick
  emerge imagemagick

#### Ubuntu

  sudo apt-get install imagemagick libmagic-dev libmagicwand-dev

### OS X

#### Homebrew

  brew install imagemagick

#### MacPorts

  sudo port install imagemagick

#### Fink

  fink install imagemagick

## Developers information

SimpleShipping provides the following models which inherit SimpleShipping::Abstract::Model:
* Shipment
* Package
* Party
* Address
* Contact

Every service adapter has its own builders which know how to represent every
separated model to build SOAP request for a specific service. For example to represent
Package model, the FedEx adapter has Fedex::PackageBuilder and the UPS adapter has
Ups::PackageBuilder. All these model builders inherit SimpleShipping::Abstract::Builder.

Request builders are used to build whole request for the service. They inherit
Abstract::RequestBuilder.

Client is a facade which provides a public API to the user.
Every service has its own client but they all inherit Abstract::Client.
All clients provide the same interface:
* .new(credentials_hash)
* #request(shipper, recipient, package, opts)


## Demo rake tasks

You can test the library against real remote requests.
For this you need to have a yaml file with your private
credentials, for example `credentials.yml` wich looks this way:

```yaml
fedex:
  key: "KEY"
  password: "SECRET"
  account_number: "ACCOUNT NUM"
  meter_number: "METER NUM"

ups:
  username: "USER"
  account_number: "ACCOUNT NUM"
  password: "SECRET"
  :access_license_number: "LICENSE NUM"
```

To run demo tasks:
```
rake demo:fedex:shipment_request[credentials.yml]
rake demo:ups:shipment_request[credentials.yml]
rake demo:ups:void_request[credentials.yml]
```

## UPS certification

To run UPS certification:

```
./script/ups_certification.rb ./credentials.yml
```

Where `credentials.yml` is file with format described above.

## TODO

* Validation for country codes and states?
* Refactor
* Ability to get more information from response object than just a label(tracking number, etc)

## Contributing to simple_shipping

* Check out the latest master to make sure the feature hasn't been implemented or the bug hasn't been fixed yet
* Check out the issue tracker to make sure someone already hasn't requested it and/or contributed it
* Fork the project
* Start a feature/bugfix branch
* Commit and push until you are happy with your contribution
* Make sure to add tests for it. This is important so I don't break it in a future version unintentionally.
* Please try not to mess with the Rakefile, version, or history. If you want to have your own version, or is otherwise necessary, that is fine, but please isolate to its own commit so I can cherry-pick around it.

## Copyright

Copyright (c) 2011 TMX Credit. Author Potapov Sergey. See LICENSE.txt for further details.
