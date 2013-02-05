# Generated by jeweler
# DO NOT EDIT THIS FILE DIRECTLY
# Instead, edit Jeweler::Tasks in Rakefile, and run 'rake gemspec'
# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = "simple_shipping"
  s.version = "0.0.10"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Potapov Sergey", "Zachary Belzer"]
  s.date = "2013-02-05"
  s.description = "This gem uses the APIs provided by UPS and FedEx to\n    service various requests on behalf of an application. In particular, it is\n    used to create shipping labels so a customer can send a package\n    postage-free"
  s.email = "blake131313@gmail.com"
  s.extra_rdoc_files = [
    "LICENSE.txt",
    "README.rdoc"
  ]
  s.files = [
    ".document",
    ".rspec",
    ".rvmrc",
    "Gemfile",
    "Gemfile.lock",
    "LICENSE.txt",
    "README.rdoc",
    "Rakefile",
    "VERSION",
    "demos/fedex_demo.rb",
    "demos/ups_demo.rb",
    "lib/simple_shipping.rb",
    "lib/simple_shipping/abstract.rb",
    "lib/simple_shipping/abstract/builder.rb",
    "lib/simple_shipping/abstract/client.rb",
    "lib/simple_shipping/abstract/model.rb",
    "lib/simple_shipping/abstract/request.rb",
    "lib/simple_shipping/abstract/response.rb",
    "lib/simple_shipping/address.rb",
    "lib/simple_shipping/contact.rb",
    "lib/simple_shipping/exceptions.rb",
    "lib/simple_shipping/fedex.rb",
    "lib/simple_shipping/fedex/client.rb",
    "lib/simple_shipping/fedex/package_builder.rb",
    "lib/simple_shipping/fedex/party_builder.rb",
    "lib/simple_shipping/fedex/request.rb",
    "lib/simple_shipping/fedex/response.rb",
    "lib/simple_shipping/fedex/shipment_builder.rb",
    "lib/simple_shipping/fedex/shipment_request.rb",
    "lib/simple_shipping/fedex/shipment_response.rb",
    "lib/simple_shipping/package.rb",
    "lib/simple_shipping/party.rb",
    "lib/simple_shipping/shipment.rb",
    "lib/simple_shipping/ups.rb",
    "lib/simple_shipping/ups/client.rb",
    "lib/simple_shipping/ups/package_builder.rb",
    "lib/simple_shipping/ups/party_builder.rb",
    "lib/simple_shipping/ups/request.rb",
    "lib/simple_shipping/ups/response.rb",
    "lib/simple_shipping/ups/shared_response_attributes.rb",
    "lib/simple_shipping/ups/ship_accept_request.rb",
    "lib/simple_shipping/ups/ship_accept_response.rb",
    "lib/simple_shipping/ups/ship_client.rb",
    "lib/simple_shipping/ups/ship_confirm_request.rb",
    "lib/simple_shipping/ups/ship_confirm_response.rb",
    "lib/simple_shipping/ups/shipment_builder.rb",
    "lib/simple_shipping/ups/shipment_request.rb",
    "lib/simple_shipping/ups/shipment_response.rb",
    "lib/simple_shipping/ups/void_client.rb",
    "lib/simple_shipping/ups/void_request.rb",
    "lib/simple_shipping/ups/void_response.rb",
    "script/ups_certification.rb",
    "simple_shipping.gemspec",
    "spec/fixtures/fedex_shipment_request.soap.xml.erb",
    "spec/fixtures/fedex_shipment_response.soap.xml.erb",
    "spec/fixtures/ups_shipment_request.soap.xml.erb",
    "spec/fixtures/ups_shipment_response.soap.xml.erb",
    "spec/fixtures/ups_void_request.soap.xml.erb",
    "spec/fixtures/ups_void_response.soap.xml.erb",
    "spec/requests/fedex_spec.rb",
    "spec/requests/ups_spec.rb",
    "spec/simple_shipping/address_spec.rb",
    "spec/simple_shipping/contact_spec.rb",
    "spec/simple_shipping/fedex/package_builder_spec.rb",
    "spec/simple_shipping/fedex/party_builder_spec.rb",
    "spec/simple_shipping/fedex/response/shipment_reponse_spec.rb",
    "spec/simple_shipping/fedex/response_spec.rb",
    "spec/simple_shipping/fedex/shipment_builder_spec.rb",
    "spec/simple_shipping/package_spec.rb",
    "spec/simple_shipping/party_spec.rb",
    "spec/simple_shipping/shipment_spec.rb",
    "spec/simple_shipping/ups/package_builder_spec.rb",
    "spec/simple_shipping/ups/party_builder_spec.rb",
    "spec/simple_shipping/ups/response/shipment_response_spec.rb",
    "spec/simple_shipping/ups/response_spec.rb",
    "spec/simple_shipping/ups/shipment_builder_spec.rb",
    "spec/spec_helper.rb",
    "spec/support/custom_matchers/basic_matcher.rb",
    "spec/support/custom_matchers/have_attribute_matcher.rb",
    "spec/support/custom_matchers/have_default_value_matcher.rb",
    "spec/support/custom_matchers/have_errors_on_matcher.rb",
    "spec/support/custom_matchers/validate_inclusion_of_matcher.rb",
    "spec/support/custom_matchers/validate_presence_of_matcher.rb",
    "spec/support/custom_matchers/validate_submodel_matcher.rb",
    "spec/support/shared_behaviours/builders_behaviour.rb",
    "spec/support/shared_behaviours/responses_behaviour.rb",
    "wsdl/fedex/ship_service_v10.wsdl",
    "wsdl/ups/Ship.wsdl",
    "wsdl/ups/Void.wsdl"
  ]
  s.homepage = "http://github.com/greyblake/simple_shipping"
  s.licenses = ["MIT"]
  s.require_paths = ["lib"]
  s.rubygems_version = "1.8.24"
  s.summary = "Interacts with UPS and FedEx APIs"

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<activesupport>, ["~> 3.1"])
      s.add_runtime_dependency(%q<activemodel>, ["~> 3.1"])
      s.add_runtime_dependency(%q<savon>, ["~> 2.1"])
      s.add_development_dependency(%q<rspec>, ["~> 2.3.0"])
      s.add_development_dependency(%q<yard>, ["~> 0.6.0"])
      s.add_development_dependency(%q<bundler>, [">= 0"])
      s.add_development_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_development_dependency(%q<rcov>, [">= 0"])
      s.add_development_dependency(%q<reek>, ["~> 1.2.8"])
      s.add_development_dependency(%q<roodi>, ["~> 2.1.0"])
      s.add_development_dependency(%q<gemfury>, [">= 0"])
      s.add_development_dependency(%q<json_pure>, [">= 0"])
      s.add_development_dependency(%q<forgery>, [">= 0"])
      s.add_development_dependency(%q<rmagick>, [">= 0"])
      s.add_development_dependency(%q<ruby-debug>, [">= 0"])
      s.add_development_dependency(%q<ruby-debug19>, [">= 0"])
    else
      s.add_dependency(%q<activesupport>, ["~> 3.1"])
      s.add_dependency(%q<activemodel>, ["~> 3.1"])
      s.add_dependency(%q<savon>, ["~> 2.1"])
      s.add_dependency(%q<rspec>, ["~> 2.3.0"])
      s.add_dependency(%q<yard>, ["~> 0.6.0"])
      s.add_dependency(%q<bundler>, [">= 0"])
      s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
      s.add_dependency(%q<rcov>, [">= 0"])
      s.add_dependency(%q<reek>, ["~> 1.2.8"])
      s.add_dependency(%q<roodi>, ["~> 2.1.0"])
      s.add_dependency(%q<gemfury>, [">= 0"])
      s.add_dependency(%q<json_pure>, [">= 0"])
      s.add_dependency(%q<forgery>, [">= 0"])
      s.add_dependency(%q<rmagick>, [">= 0"])
      s.add_dependency(%q<ruby-debug>, [">= 0"])
      s.add_dependency(%q<ruby-debug19>, [">= 0"])
    end
  else
    s.add_dependency(%q<activesupport>, ["~> 3.1"])
    s.add_dependency(%q<activemodel>, ["~> 3.1"])
    s.add_dependency(%q<savon>, ["~> 2.1"])
    s.add_dependency(%q<rspec>, ["~> 2.3.0"])
    s.add_dependency(%q<yard>, ["~> 0.6.0"])
    s.add_dependency(%q<bundler>, [">= 0"])
    s.add_dependency(%q<jeweler>, ["~> 1.6.4"])
    s.add_dependency(%q<rcov>, [">= 0"])
    s.add_dependency(%q<reek>, ["~> 1.2.8"])
    s.add_dependency(%q<roodi>, ["~> 2.1.0"])
    s.add_dependency(%q<gemfury>, [">= 0"])
    s.add_dependency(%q<json_pure>, [">= 0"])
    s.add_dependency(%q<forgery>, [">= 0"])
    s.add_dependency(%q<rmagick>, [">= 0"])
    s.add_dependency(%q<ruby-debug>, [">= 0"])
    s.add_dependency(%q<ruby-debug19>, [">= 0"])
  end
end

