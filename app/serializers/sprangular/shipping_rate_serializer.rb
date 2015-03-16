module Sprangular
  class ShippingRateSerializer < BaseSerializer
    attributes :id, :name, :cost, :selected, :shipping_method_id,
               :shipping_method_code, :display_cost
  end
end
