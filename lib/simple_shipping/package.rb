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
class SimpleShipping::Package < SimpleShipping::Base::Model
  attr_accessor :length, :width, :height, :dimension_units,
                :weight, :weight_units, :type_code

  validates_presence_of :length, :width, :height, :dimension_units,
                        :weight, :weight_units
  validates_inclusion_of :weight_units   , :in => [:kg, :lb]
  validates_inclusion_of :dimension_units, :in => [:in, :cm]

  set_default_values :type_code       => :customer_supplied,
                     :weight_units    => :lb,
                     :dimension_units => :in
end
