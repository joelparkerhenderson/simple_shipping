require 'spec_helper'

describe SimpleShipping::Party do
  it { should be_kind_of SimpleShipping::Abstract::Model }

  describe 'attributes' do
    it { should have_attribute :contact }
    it { should have_attribute :address }
    it { should have_attribute :account_number }
  end

  describe 'validations' do
    it { should validate_presence_of :contact }
    it { should validate_presence_of :address }
    it { should validate_submodel(:address).as(SimpleShipping::Address) }
    it { should validate_submodel(:contact).as(SimpleShipping::Contact) }
  end
end
