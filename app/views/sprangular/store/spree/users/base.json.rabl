attributes *user_attributes

child completed_orders: :orders do
  attributes *order_attributes
end

child shipping_address: :shipping_address do
  extends '/store/spree/addresses/base'
end

child billing_address: :billing_address do
  extends '/store/spree/addresses/base'
end

child payment_sources: :payment_sources do
  extends '/store/spree/credit_cards/base'
end
