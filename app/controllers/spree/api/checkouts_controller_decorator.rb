module Sprangular::ApiCheckoutControllerDecorator
  def quick_update
    load_order(true)
    authorize! :update, @order, order_token

    @selected_rate = find_selected_rate(@order)

    revert_to_cart

    if params[:complete]
      advance_until(&:complete?)
    else
      advance_until(&:payment?)
    end

    respond_with(@order, default_template: 'spree/api/orders/show')
  end

private
  def revert_to_cart
    @order.update(state: 'cart') unless @order.cart?
  end

  def advance_until
    update_order
    advance until yield(@order)
  end

  def advance
    if @order.delivery? && @selected_rate
      shipment = @order.shipments.first
      available_rate = shipment.shipping_rates.detect {|rate| rate.shipping_method_id == @selected_rate.shipping_method_id && rate.cost == @selected_rate.cost}
      shipment.update(selected_shipping_rate_id: available_rate.id)
    end
    @order.next!
  end

  def update_order
    @order.update_from_params(params, permitted_checkout_attributes, request.headers.env)
  end

  def find_selected_rate(order)
    return unless attrs = params[:order][:shipments_attributes].try(:first)

    shipment = order.shipments.detect {|shipment| shipment.id == attrs[:id].to_i}
    shipment.shipping_rates.find(attrs[:selected_shipping_rate_id])
  end
end

Spree::Api::CheckoutsController.send :prepend, Sprangular::ApiCheckoutControllerDecorator
