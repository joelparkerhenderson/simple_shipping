require 'spec_helper'

describe SimpleShipping::Ups::ShipmentBuilder do
  it_should_behave_like "builders"

  describe 'validation' do
    it 'validates inclusion of service_code' do
      shipment = SimpleShipping::Shipment.new
      shipment.stub!(:valid? => true)

      lambda {
        SimpleShipping::Ups::ShipmentBuilder.build(shipment, :service_code => :ground)
      }.should_not raise_error SimpleShipping::ValidationError
      lambda {
        SimpleShipping::Ups::ShipmentBuilder.build(shipment, :service_code => :bad)
      }.should raise_error SimpleShipping::ValidationError
    end
  end
end
