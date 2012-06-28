require 'spec_helper'

module SimpleShipping::Ups
  describe PartyBuilder do
    it_should_behave_like "builders"

    it 'validate account number if party is shipper' do
      shipper = SimpleShipping::Party.new

      shipper.stub!(:valid? => true)
      lambda {
        PartyBuilder.build(shipper, :shipper => true)
      }.should raise_error SimpleShipping::ValidationError

      shipper.stub!(:account_number => '123')
      lambda {
        PartyBuilder.build(shipper, :shipper => true)
      }.should_not raise_error SimpleShipping::ValidationError
    end
  end

  describe "build" do
    it "should include all addresses" do
      contact = SimpleShipping::Contact.new(:phone_number => "5555555555", :person_name => "Frank")
      address = SimpleShipping::Address.new(:country_code => "US", :state_code => "IL", :city => "Chicago", :postal_code => "60622")
      address.street_line = "foo"
      address.street_line_2 = "bar"
      address.street_line_3 = "baz"

      shipper = SimpleShipping::Party.new(:contact => contact, :address => address)
      party = PartyBuilder.build(shipper)
      party['v11:Address']['v11:AddressLine'].should have(3).addresses
    end

    it "should exclude nil addresses" do
      contact = SimpleShipping::Contact.new(:phone_number => "5555555555", :person_name => "Frank")
      address = SimpleShipping::Address.new(:country_code => "US", :state_code => "IL", :city => "Chicago", :postal_code => "60622")
      address.street_line = "foo"
      address.street_line_2 = nil
      address.street_line_3 = "baz"

      shipper = SimpleShipping::Party.new(:contact => contact, :address => address)
      party = PartyBuilder.build(shipper)
      party['v11:Address']['v11:AddressLine'].should have(2).addresses
    end
  end
end
