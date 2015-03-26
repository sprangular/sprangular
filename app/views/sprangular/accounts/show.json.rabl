object @user
extends 'sprangular/spree/users/base'

child(addresses: :addresses) do
  extends 'sprangular/spree/addresses/base'
end

child(@order => :current_order) do
  extends 'spree/api/orders/show'
end
