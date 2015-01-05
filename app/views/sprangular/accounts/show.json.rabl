object @user
extends 'sprangular/spree/users/base'

child(:past_ship_addresses => :shipping_addresses) do
  extends 'sprangular/spree/addresses/base'
end

child(:past_bill_addresses => :billing_addresses) do
  extends 'sprangular/spree/addresses/base'
end
