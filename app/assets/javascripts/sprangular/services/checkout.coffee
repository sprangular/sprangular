Sprangular.service "Checkout", ($http, _, Env, Account, Cart) ->

  checkout =
    savePromo: (code) ->
      params =
        order:
          coupon_code: code

      @put(params)

    update: ->
      order = Cart.current

      params =
        order:
          use_billing: order.shipToBillAddress
          coupon_code: order.couponCode
          ship_address_attributes: order.actualShippingAddress().serialize()
          bill_address_attributes: order.billingAddress.serialize()
        state: 'confirm'

      if order.shippingMethod
        params.order.shipping_method_id = order.shipping_method_id

      if order.shippingRate
        params['order[shipments_attributes][][selected_shipping_rate_id]'] = order.shippingRate.id

      @put(params)

    complete: ->
      paymentMethodId = Env.config.payment_methods['gateway'].id
      params =
        'order[payments_attributes][][payment_method_id]': paymentMethodId
        'state': 'complete'

      order = Cart.current
      card = order.creditCard

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
        params["payment_source[#{paymentMethodId}][name]"] = order.billingAddress.fullName()

      @put(params)

    next: ->
      @put(null, 'next')

    put: (params, path) ->
      params ||= {}

      $http.put("/spree/api/checkouts/#{Cart.current.number}/#{path}", $.param(params))
           .success (response) ->
             Cart.load(response) unless response.error
           .error (response) ->
             Cart.errors(response.errors)

  checkout
