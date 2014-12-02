Spree::Api::CheckoutsController.class_eval do
  def quick_update
    load_order(true)
    authorize! :update, @order, order_token

    revert_to_cart
    advance_to_payment
    advance_to_complete if params[:complete]

    respond_with(@order, default_template: 'spree/api/orders/show')
  end

private
  def revert_to_cart
    @order.update(state: 'cart') unless @order.cart?
  end

  def advance_to_payment
    until @order.payment?
      update_order
      @order.next!
    end
  end

  def advance_to_complete
    update_order
    @order.finalize!
  end

  def update_order
    @order.update_from_params(params, permitted_checkout_attributes, request.headers.env)
  end
end
