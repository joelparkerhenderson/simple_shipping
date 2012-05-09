# Represents a package which should be sent from {SimpleShipping::Party shipper}
# to {SimpleShipping::Party recipient}.
#
# == Attributes:
# * _dimenstion_units_ (:in, :cm). Default is :in.
# * _weight_units_ (:kg, :lb). Default is :lb.
# * _legth_ (in dimension units)
# * _width_ (in dimension units)
# * _height_ (in dimension units)
# * _weight_ (in weight  units)
# * _packaging_type_ 
#
# == Packaging type values:
# * :envelope
# * :your
# * :tube
# * :pak
# * :box
# * :box_10kg
# * :box_25kg
class SimpleShipping::Package < SimpleShipping::Abstract::Model
  attr_accessor :length, :width, :height, :dimension_units, :weight, :weight_units, :packaging_type

  validates_presence_of :length, :width, :height, :dimension_units, :if => :custom_package?
  validates_presence_of :weight, :weight_units

  validates_inclusion_of :weight_units   , :in => [:kg, :lb]
  validates_inclusion_of :dimension_units, :in => [:in, :cm], :if => :custom_package?
  validates_inclusion_of :packaging_type , :in => [:envelope, :pak, :tube, :your, :box, :box_10kg, :box_25kg]

  set_default_values :packaging_type  => :your,
                     :weight_units    => :lb,
                     :dimension_units => :in

  def custom_package?
    packaging_type == :your
  end
end
