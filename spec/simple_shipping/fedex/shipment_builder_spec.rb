require 'spec_helper'

describe SimpleShipping::Fedex::ShipmentBuilder do
  it_should_behave_like "builders"

  def build_it(opts = {})
    shipment = SimpleShipping::Shipment.new
    shipment.stub!(:valid? => true)
    SimpleShipping::Fedex::ShipmentBuilder.build(shipment, opts)
  end

  describe 'validation' do
    it 'validates inclusion of :dropoff_type' do
      lambda { build_it(:dropoff_type => :bad_value) }.should raise_error SimpleShipping::ValidationError
      lambda { build_it(:dropoff_type => :drop_box) }.should_not raise_error SimpleShipping::ValidationError
    end

    it 'validates inclusion of :service_type' do
      lambda { build_it(:service_type => :bad_value) }.should raise_error SimpleShipping::ValidationError
      lambda { build_it(:service_type => :fedex_ground ) }.should_not raise_error SimpleShipping::ValidationError
    end

    it 'validates inclusion of :packaging_type' do
      lambda { build_it(:packaging_type => :bad_value) }.should raise_error SimpleShipping::ValidationError
      lambda { build_it(:packaging_type => :box_10kg) }.should_not raise_error SimpleShipping::ValidationError
    end
  end
end
