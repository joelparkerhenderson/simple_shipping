$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))
$LOAD_PATH.unshift(File.dirname(__FILE__))
require 'rspec'
require 'simple_shipping'
require 'simple_shipping/fedex'
require 'simple_shipping/ups'

require "savon/mock/spec_helper"
require 'webmock/rspec'
require "timecop"
require "erubis"
require 'equivalent-xml'


# Requires supporting files with custom matchers and macros, etc,
# in ./support/ and its subdirectories.
require File.expand_path("../support/custom_matchers/basic_matcher", __FILE__)
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each {|f| require f}

RSpec.configure do |config|
  config.include SimpleShipping::CustomMatchers
  config.include Savon::SpecHelper
  config.after(:each)  { savon.unmock! }

  config.before(:each) do
    # We are going to enable webmock in some spec on-demand.
    # This is the reason why this config directive is placed in before(:each) hook -- aignatyev 20130204
    WebMock.disable_net_connect!(:allow_localhost => true)
  end

  def fixtures_dir
    Pathname.new(File.expand_path('../fixtures', __FILE__))
  end

  def fixture(name, vars = {})
    path = fixtures_dir.join(name.to_s + ".soap.xml.erb")
    template = File.open(path).read

    Erubis::Eruby.new(template).result(vars)
  end
end
