Sprangular.service "Checkout", ($http, $q, _, Env, Account, Cart) ->

  service =
    savePromo: (code) ->
      params =
        coupon_code: code

      config =
        headers:
          'X-Spree-Order-Token': Cart.current.token

      deferred = $q.defer()

      $http.put("/spree/api/orders/#{Cart.current.number}/apply_coupon_code", $.param(params), config)
           .success (response) ->
             Cart.load(response.order)

             if response.error
               deferred.reject(response)
             else
               deferred.resolve(response)

           .error (response) ->
             response.error ||= "Coupon code #{code} not found."
             deferred.reject(response)

      deferred.promise

    update: (goto) ->
      order = Cart.current
      card  = order.creditCard

      params =
        goto: goto
        order:
          ship_address_attributes: order.actualBillingAddress().serialize()
          bill_address_attributes: order.shippingAddress.serialize()

      @_addShippingRate(params, order)

      @put(params)

    setAddresses: ->

    setDelivery: ->

    setPayment: ->

    confirm: ->
      order = Cart.current
      card  = order.creditCard
      paymentMethodId = @_findPaymentMethodId()

      params =
        goto: 'complete'
        'order[payments_attributes][][payment_method_id]': paymentMethodId
        order:
          ship_address_attributes: order.shippingAddress.serialize()
          bill_address_attributes: order.actualBillingAddress().serialize()
        payment_source: {}

      @_addShippingRate(params, order)

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
        .then (data) ->
          Cart.lastOrder = Sprangular.extend(data, Sprangular.Order)

          service.trackOrder(Cart.lastOrder)

          Account.reload().then ->
            Cart.init()

    trackOrder: (order) ->
      return if typeof(ga) is 'undefined'

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

      deferred = $q.defer()

      $http.put(url, $.param(params), config)
        .success (response) ->
          Cart.load(response) unless response.error
          deferred.resolve(Cart.current)

        .error (response) ->
          errors = response.errors || response.exception

          if errors
            Cart.errors(base: errors)
            deferred.resolve(Cart.current)
          else
            deferred.reject()

      deferred.promise

    _addShippingRate: (params, order) ->
      if order.shippingRate
        params['order[shipments_attributes][][id]'] = order.shipment.id
        params['order[shipments_attributes][][selected_shipping_rate_id]'] = order.shippingRate.id

    _findPaymentMethodId: ->
      paymentMethod = _.find Env.config.payment_methods, (method) -> method.name == 'Credit Card'

      alert('Payment method "Credit Card" not found') unless paymentMethod

      paymentMethod.id

  service
