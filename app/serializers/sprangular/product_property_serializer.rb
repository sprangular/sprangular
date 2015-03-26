module Sprangular
  class ProductPropertySerializer < BaseSerializer
    attributes :id, :product_id, :property_id, :value, :property_name
  end
end
