require 'spec_helper'

describe SimpleShipping::Ups::ShipmentBuilder do
  it_should_behave_like "builders"

  describe 'validation' do
    it 'validates inclusion of service_types' do
      shipment = SimpleShipping::Shipment.new
      shipment.stub!(:valid? => true)

      lambda {
        SimpleShipping::Ups::ShipmentBuilder.build(shipment, :service_type => :ground)
      }.should_not raise_error SimpleShipping::ValidationError
      lambda {
        SimpleShipping::Ups::ShipmentBuilder.build(shipment, :service_type => :bad)
      }.should raise_error SimpleShipping::ValidationError
    end
  end
end
