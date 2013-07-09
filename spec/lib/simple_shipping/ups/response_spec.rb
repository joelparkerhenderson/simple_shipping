require 'spec_helper'

describe SimpleShipping::Ups::Response do
  it_should_behave_like "responses"

  context "when success response is received" do
    subject { response }

    let(:response_fixture) { fixture("ups_shipment_response") }
    let(:http_response)  { ::HTTPI::Response.new(200, {}, response_fixture) }
    let(:savon_response) do
      ::Savon::Response.new(
        http_response,
        {
          strip_namespaces: true,
          convert_response_tags_to: ->(tag) { tag.snakecase.to_sym }
        },
        {}
      )
    end
    let(:response)       { ::SimpleShipping::Ups::ShipmentResponse.new(savon_response) }

    its(:shipment_identification_number) { should eq("1Z35679R0294268838") }
    its(:tracking_number)                { should eq("1Z35679R0294268838") }

    describe "label image" do
      let(:response_fixture) { fixture("ups_shipment_response_with_faked_label_data") }

      its(:label_html) { should eq("HTML_IMAGE_DATA") }
    end
  end
end
