require 'spec_helper'

module SimpleShipping
  describe Ups::PackageBuilder do
    it_should_behave_like "builders"

    describe ".build" do
      before do
        @package = Package.new(:weight => 1, :height => 1, :width => 1, :length => 1)
      end
      it "should include dimensions when packaging_type is 'your'" do
        package    = @package.packaging_type = :your
        attributes = described_class.build(@package)
        attributes.should have_key('Dimensions')
      end

      (Ups::PackageBuilder::PACKAGING_TYPES.keys - [:your]).each do |type|
        it "should not include dimensions when packaging_type is '#{type}'" do
          package    = @package.packaging_type = :envelope
          attributes = described_class.build(@package)
          attributes.should_not have_key('Dimensions')
        end
      end
    end
  end
end
