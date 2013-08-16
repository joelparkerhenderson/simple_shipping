require 'spec_helper'

describe "UPS test" do
  let(:credentials) {{
    :username => "Joe13",
    :password => "JoesSecretWord",
    :account_number => "1010101",
    :access_license_number => "Joe's license"
  }}

  let(:demo) do
    options = credentials.merge!(:live => false)
    SimpleShipping::Demo::Ups.new(options)
  end

  let(:erb_request_vars) do
    credentials.merge(:shipment_identification_number => demo.shipment_identification_number)
  end

  describe "ship_client" do
    describe "#shipment_request" do
      it "builds correct SOAP request envelope" do
        req_matcher = lambda do |req|
          expected = Nokogiri::XML(fixture(:ups_shipment_request, erb_request_vars))
          actual = Nokogiri::XML(req.body)

          actual.root.should be_equivalent_to(expected.root)
          #actual.root.to_s.should == expected.root.to_s

          true
        end

        req = stub_http_request(:post, demo.ship_client.class.testing_address).
          with(&req_matcher).
          to_return(:body => fixture(:ups_shipment_response), :status => 200, :headers => {})

        resp = demo.shipment_request(

        )


        resp.label_image_base64.should be_present

        req.should have_been_made
      end
    end
  end

  describe "void client" do
    describe "#void_request" do
      it "builds correct SOAP request envelope" do
        req_matcher = lambda do |req|
          expected = Nokogiri::XML(fixture(:ups_void_request, erb_request_vars))

          actual = Nokogiri::XML(req.body)

          actual.root.should be_equivalent_to(expected.root)
          #actual.root.to_s.should == expected.root.to_s

          true
        end

        req = stub_http_request(:post, demo.void_client.class.testing_address).
          with(&req_matcher).
          to_return(:body => fixture(:ups_void_response), :status => 200, :headers => {})

        expect{ demo.void_request }.to(
          # NOTE: Exception message is important! This is how we can find out whether SOAP request was made correct -- aignatyev 20130204
          raise_exception(SimpleShipping::RequestError, /No shipment found within the allowed void period/)
        )

        req.should have_been_made
      end
    end
  end
end
