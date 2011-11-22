require 'spec_helper'

describe SimpleShipping::Ups::PartyBuilder do
  it_should_behave_like "builders"
  
  it 'validate account number if party is shipper' do
    shipper = SimpleShipping::Party.new
    shipper.stub!(:valid? => true)
    lambda {
      SimpleShipping::Ups::PartyBuilder.build(shipper, :shipper => true)
    }.should raise_error SimpleShipping::ValidationError
    shipper.stub!(:account_number => '123')
    lambda {
      SimpleShipping::Ups::PartyBuilder.build(shipper, :shipper => true)
    }.should_not raise_error SimpleShipping::ValidationError
  end
end
