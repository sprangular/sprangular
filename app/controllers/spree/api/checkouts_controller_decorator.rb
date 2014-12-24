module Sprangular::ApiCheckoutControllerDecorator
  def quick_update
    binding.pry
    load_order(true)
    authorize! :update, @order, order_token

    revert_to_cart

    if params[:complete]
      advance_to_complete
    else
      advance_to_payment
    end

    respond_with(@order, default_template: 'spree/api/orders/show')
  end

private
  def revert_to_cart
    @order.update(state: 'cart') unless @order.cart?
  end

  def advance_to_payment
    update_order
    until @order.payment?
      @order.next!
    end
  end

  def advance_to_complete
    update_order
    until @order.complete?
      @order.next!
    end
  end

  def update_order
    @order.update_from_params(params, permitted_checkout_attributes, request.headers.env)
  end
end

Spree::Api::CheckoutsController.prepend Sprangular::ApiCheckoutControllerDecorator

