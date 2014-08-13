object @user
extends 'store/spree/users/base'

child(current_order => :current_order) do
  extends 'store/spree/orders/base'
end

child(:past_ship_addresses => :shipping_addresses) do
  extends 'store/spree/addresses/base'
end

child(:past_bill_addresses => :billing_addresses) do
  extends 'store/spree/addresses/base'
end
