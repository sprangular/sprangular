module Sprangular::ApiCheckoutControllerDecorator
  def quick_update
    load_order(true)
    authorize! :update, @order, order_token
    
    Sprangular::OrderUpdater.update(@order, request, params)

    respond_with(@order, default_template: 'spree/api/orders/show')
  end

  def refresh_shipping_rates
    load_order(true)
    authorize! :update, @order, order_token    

    @order.create_proposed_shipments
    @order.updater.update_shipments
    respond_with(@order, default_template: 'spree/api/orders/show')
  end
end

Spree::Api::CheckoutsController.send :prepend, Sprangular::ApiCheckoutControllerDecorator
