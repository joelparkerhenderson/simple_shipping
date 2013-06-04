require 'spec_helper'

describe SimpleShipping::Ups::Response do
  it_should_behave_like "responses"

  it { should respond_to :tracking_number }
  context 'when retrieve tracking_number' do
    subject { instance.tracking_number }

    let(:instance) { described_class.new(nil) }
    let(:tracking_number) { 'TNUMBER' }

    it 'should use shipment_results/package_results/tracking_number xpath' do
      instance.
        should_receive(:value_of).
        with(:shipment_results, :package_results, :tracking_number).
        and_return(tracking_number)

      subject
    end
  end
end
