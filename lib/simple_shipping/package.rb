class SimpleShipping::Package < SimpleShipping::Base::Model
  attr_accessor :length, :width, :height, :dimension_units,
                :weight, :weight_units, :type_code

  validates_presence_of :length, :width, :height, :dimension_units,
                        :weight, :weight_units
  validates_inclusion_of :weight_units   , :in => [:kg, :lb]
  validates_inclusion_of :dimension_units, :in => [:in, :cm]

  set_default_values :type_code => :customer_supplied
end
