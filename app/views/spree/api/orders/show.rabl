object @order
extends "spree/api/orders/order"

node(:use_billing) { @order.bill_address == @order.ship_address }

if lookup_context.find_all("spree/api/orders/#{@order.state}").present?
  extends "spree/api/orders/#{@order.state}"
end

child :billing_address => :bill_address do
  extends "spree/api/addresses/show"
end

child :shipping_address => :ship_address do
  extends "spree/api/addresses/show"
end

child :line_items => :line_items do
  extends "spree/api/line_items/show"
end

child :payments => :payments do
  attributes *payment_attributes

  child :payment_method => :payment_method do
    attributes :id, :name, :environment
  end

  child :source => :source do
    attributes *payment_source_attributes
  end
end

child :shipments => :shipments do
  extends "spree/api/shipments/small"
end

child :line_item_promotion_adjustments => :line_item_adjustments do
  extends "spree/api/adjustments/show"
end

child :adjustments => :adjustments do
  extends "spree/api/adjustments/show"
end

child :products => :products do
  extends "spree/api/products/show"
end
