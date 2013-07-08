require 'spec_helper'

describe SimpleShipping::Address do
  it { should be_kind_of SimpleShipping::Abstract::Model }

  describe 'attributes' do
    it { should have_attribute :country_code }
    it { should have_attribute :state_code }
    it { should have_attribute :city }
    it { should have_attribute :street_line }
    it { should have_attribute :street_line_2 }
    it { should have_attribute :street_line_3 }
    it { should have_attribute :postal_code }
  end

  describe 'validations' do
    it {should validate_presence_of :country_code }
  end
end
