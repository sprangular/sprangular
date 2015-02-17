Sprangular.service "Checkout", ($http, $q, _, Env, Account, Cart) ->

  service =
    savePromo: (code) ->
      params =
        order:
          coupon_code: code

      @put(params)

    update: ->
      order = Cart.current
      card  = order.creditCard

      params =
        order:
          use_billing: order.shipToBillAddress
          coupon_code: order.couponCode
          ship_address_attributes: order.actualShippingAddress().serialize()
          bill_address_attributes: order.billingAddress.serialize()
        'order[payments_attributes][][payment_method_id]': @_findPaymentMethodId()
        payment_source: {}

      if order.shippingRate
        params['order[shipments_attributes][][id]'] = order.shipment.id
        params['order[shipments_attributes][][selected_shipping_rate_id]'] = order.shippingRate.id

      @put(params)

    complete: ->
      order = Cart.current
      card  = order.creditCard
      paymentMethodId = @_findPaymentMethodId()

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

          service.trackOrder(Cart.lastOrder)

          Account.reload().then ->
            Cart.init()

    trackOrder: (order) ->
      return unless ga

      ga "ecommerce:addTransaction",
        id:       order.number
        revenue:  order.total
        shipping: order.shipTotal
        tax:      order.taxTotal

      for item in order.items
        ga "ecommerce:addItem",
          id:       order.number
          name:     item.variant.name
          sku:      item.variant.sku
          price:    item.price
          quantity: item.quantity

      ga "ecommerce:send"

    put: (params) ->
      url = "/api/checkouts/#{Cart.current.number}/quick_update"
      params = params ||= {}

      config =
        headers:
          'X-Spree-Order-Token': Cart.current.token

      Cart.current.errors = null

      $http.put(url, $.param(params), config)
        .success (response) ->
          Cart.load(response) unless response.error
        .error (response) ->
          Cart.errors(response.errors || response.exception)

    _findPaymentMethodId: ->
      paymentMethod = _.find Env.config.payment_methods, (method) -> method.name == 'Credit Card'

      alert('Payment method "Credit Card" not found') unless paymentMethod

      paymentMethod.id

  service
