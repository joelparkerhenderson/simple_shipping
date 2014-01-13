require 'spec_helper'

describe SimpleShipping::Shipment do
  it { should be_kind_of SimpleShipping::Abstract::Model }

  describe 'attributes' do
    it { should have_attribute :shipper }
    it { should have_attribute :recipient }
    it { should have_attribute :package }
    it { should have_attribute :payor }
  end

  describe 'validations' do
    it { should validate_presence_of :shipper }
    it { should validate_presence_of :recipient }
    it { should validate_presence_of :package }
    it { should validate_presence_of :payor }
    it { should validate_inclusion_of(:payor).in(:shipper, :recipient) }
    it { should validate_submodel(:shipper).as(SimpleShipping::Party) }
    it { should validate_submodel(:recipient).as(SimpleShipping::Party) }
    it { should validate_submodel(:package).as(SimpleShipping::Package) }

    it 'validates payor account number' do
      recipient = SimpleShipping::Party.new(:account_number => '123')
      shipment  = SimpleShipping::Shipment.new(:recipient => recipient, :payor => :recipient)
      shipment.should_not have_errors_on(:abstract)
      shipment.recipient.account_number = nil
      shipment.should have_errors_on(:abstract)
    end
  end

  describe 'default values' do
    it { should have_default_value(:shipper).for_attribute(:payor) }
  end
end
