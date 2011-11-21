require 'spec_helper'

describe SimpleShipping::Package do
  it { should be_kind_of SimpleShipping::Abstract::Model }

  describe 'attributes' do
    it { should have_attribute :length }
    it { should have_attribute :width }
    it { should have_attribute :height }
    it { should have_attribute :dimension_units }
    it { should have_attribute :weight }
    it { should have_attribute :weight_units }
  end

  describe 'validations' do
    it { should validate_presence_of :length }
    it { should validate_presence_of :width }
    it { should validate_presence_of :height }
    it { should validate_presence_of :dimension_units }
    it { should validate_presence_of :weight }
    it { should validate_presence_of :weight_units }
    it { should validate_inclusion_of(:weight_units).in(:kg, :lb) }
    it { should validate_inclusion_of(:dimension_units).in(:cm, :in) }
  end

  describe 'default values' do
    it { should have_default_value(:in).for_attribute(:dimension_units) }
    it { should have_default_value(:lb).for_attribute(:weight_units) }
  end
end
