Sprangular.service "Checkout", ($http, _, Env, Account, Cart) ->

  checkout =
    update: ->
      order = Cart.current

      params =
        use_billing: order.shipToBillAddress
        order:
          ship_address_attributes: order.actualShippingAddress().serialize()
          bill_address_attributes: order.billingAddress.serialize()
        state: 'confirm'

      if order.shippingMethod
        params['order[shipments_attributes][][id]'] = order.shippingMethod.id

      if order.shippingRate
        params['order[shipments_attributes][][selected_shipping_rate_id]'] = order.shippingRate.id

      @put(params)

    complete: ->
      paymentMethodId = Env.config.payment_methods['gateway'].id
      params =
        'order[payments_attributes][][payment_method_id]': paymentMethodId
        'state': 'complete'

      card = Cart.current.creditCard

      if card.id
        params['use_existing_card'] = 'yes'
        params['existing_card'] = card.id
      else
        params["use_existing_card"] = 'no'
        params["payment_source[#{paymentMethodId}][number]"] = card.number
        params["payment_source[#{paymentMethodId}][verification_value]"] = card.cvc
        params["payment_source[#{paymentMethodId}][cc_type]"] = card.ccType
        params["payment_source[#{paymentMethodId}][month]"] = card.month
        params["payment_source[#{paymentMethodId}][year]"] = card.year
        params["payment_source[#{paymentMethodId}][last_digits]"] = card.lastDigits
        params["payment_source[#{paymentMethodId}][name]"] = card.name

      @put(params)

    put: (params) ->
      params ||= {}

      $http.put("/spree/api/checkouts/#{Cart.current.number}", $.param(params))
           .success(Cart.load)
           .error (response) ->
             Cart.error(response.errors)

  checkout
