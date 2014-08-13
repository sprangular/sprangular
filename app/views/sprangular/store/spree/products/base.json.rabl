object @product
attributes *product_attributes
node(:has_variants) { |p| p.has_variants? }

child master: :master do
  extends "/store/spree/variants/base"
end

child variants: :variants do
  extends "/store/spree/variants/base"
end

child option_types: :option_types do
  attributes *option_type_attributes
end

child product_properties: :product_properties do
  attributes *product_property_attributes
end