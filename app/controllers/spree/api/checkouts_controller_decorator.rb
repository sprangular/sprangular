module Sprangular::ApiCheckoutControllerDecorator
  def quick_update
    load_order(true)
    authorize! :update, @order, order_token

    Sprangular::OrderUpdater.update(@order, request, params)

    respond_with(@order, default_template: 'spree/api/orders/show')
  end
end

Spree::Api::CheckoutsController.send :prepend, Sprangular::ApiCheckoutControllerDecorator
