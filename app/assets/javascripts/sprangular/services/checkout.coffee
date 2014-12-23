Sprangular.service "Checkout", ($http, $q, _, Env, Account, Cart) ->

  service =
    savePromo: (code) ->
      params =
        order:
          coupon_code: code

      @put(params)

    update: ->
      order = Cart.current
      paymentMethodId = Env.config.payment_methods['gateway'].id

      params =
        order:
          use_billing: order.shipToBillAddress
          coupon_code: order.couponCode
          ship_address_attributes: order.actualShippingAddress().serialize()
          bill_address_attributes: order.billingAddress.serialize()

      if order.shippingMethod
        params.order.shipping_method_id = order.shippingMethodId

      if order.shippingRate
        params['order[shipments_attributes][][selected_shipping_rate_id]'] = order.shippingRate.id

      if order.creditCard
        params['order[payments_attributes][][payment_method_id]'] = paymentMethodId

      @put(params)

    complete: ->
      order = Cart.current
      card  = order.creditCard
      paymentMethodId = Env.config.payment_methods['gateway'].id

      params =
        complete: true
        'order[payments_attributes][][payment_method_id]': paymentMethodId
        order: {}
        payment_source: {}

      if card.id
        params.order.existing_card = card.id
      else
        sourceParams = {}
        sourceParams.number = card.number
        sourceParams.cc_type = card.type
        sourceParams.verification_value = card.cvc
        sourceParams.month = card.month
        sourceParams.year = card.year
        sourceParams.name = order.billingAddress.fullName()

        params.payment_source[paymentMethodId] = sourceParams

      @put(params)
        .success (data) ->
          Cart.lastOrder = Sprangular.extend(data, Sprangular.Order)
          Account.reload().then ->
            Cart.init()

    put: (params) ->
      params ||= {}

      Cart.current.errors = null

      $http.put("/api/checkouts/#{Cart.current.number}/quick_update", $.param(params))
           .success (response) ->
             Cart.load(response) unless response.error
           .error (response) ->
             Cart.errors(response.errors || response.exception)

  service
