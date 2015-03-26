module Sprangular
  class ShippingMethodSerializer < BaseSerializer
    attributes :id, :code, :name

    has_many :shipping_categories,
             serializer: Sprangular::ShippingCategorySerializer
    has_many :zones, serializer: Sprangular::ZoneSerializer
  end
end
