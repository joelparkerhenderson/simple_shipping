require 'spec_helper'

describe "FedEx integration test" do
  before{ Timecop.freeze }
  after{ Timecop.return }

  #let(:credentials) do
  #  YAML.load_file(SimpleShipping::DEMO_CREDENTIALS_FILE)['fedex'].symbolize_keys!
  #end

  let(:credentials) {{
    :key            => 'fedex key',
    :password       => 'secret word',
    :account_number => '101010101',
    :meter_number   => '202020202'
  }}

  let(:demo) do
    options = credentials.merge(:live => false)
    SimpleShipping::Demo::Fedex.new(options)
  end

  context "#shipment_request" do
    it "builds correct SOAP request envelope" do
      req_matcher = lambda do |req|
        expected = Nokogiri::XML(fixture(:fedex_shipment_request, credentials))
        actual   = Nokogiri::XML(req.body)

        actual.root.should be_equivalent_to(expected.root).respecting_element_order

        req.headers['Soapaction'].should == %{"processShipment"}

        true
      end

      req = stub_http_request(:post, demo.fedex_client.class.testing_address).
        with(&req_matcher).
        to_return(:body => fixture(:fedex_shipment_response), :status => 200, :headers => {})

      resp = demo.shipment_request

      resp.label_image_base64.should be_present

      req.should have_been_made
    end
  end
end
