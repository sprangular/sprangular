Sprangular.service "Checkout", ($http, $q, _, Env, Account, Cart) ->

  service =
    savePromo: (code) ->
      params =
        coupon_code: code

      Cart.current.loading = true

      config =
        ignoreLoadingIndicator: true
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

    setAddresses: ->
      order  = Cart.current
      params =
        order:
          ship_address_attributes: order.actualBillingAddress().serialize()
          bill_address_attributes: order.shippingAddress.serialize()
        state: 'address'

      @put(params, ignoreLoadingIndicator: true)

    setDelivery: ->
      order  = Cart.current
      params =
        'order[shipments_attributes][][id]': order.shipment.id
        'order[shipments_attributes][][selected_shipping_rate_id]': order.shippingRate.id
        state: 'delivery'

      @put(params, ignoreLoadingIndicator: true)

    setPayment: ->
      order  = Cart.current
      paymentMethodId = @_findPaymentMethodId()

      params =
        'order[payments_attributes][][payment_method_id]': paymentMethodId
        'order[existing_card]': ''
        'state': 'payment'

      @put(params, ignoreLoadingIndicator: true)

    confirm: ->
      order = Cart.current
      card  = order.creditCard
      paymentMethodId = @_findPaymentMethodId()

      params =
        order: {}
        'order[payments_attributes][][payment_method_id]': paymentMethodId
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
        .then (data) ->
          Cart.lastOrder = Sprangular.extend(data, Sprangular.Order)

          service.trackOrder(Cart.lastOrder)

          if Account.isGuest
            Cart.init()
          else
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

    put: (params={}, config={}) ->
      order = Cart.current
      url = "/spree/api/checkouts/#{order.number}"

      config.headers =
        'X-Spree-Order-Token': order.token

      order.errors = null
      order.loading = true

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

    _findPaymentMethodId: ->
      paymentMethod = _.find Env.config.payment_methods, (method) -> method.name == 'Credit Card'

      alert('Payment method "Credit Card" not found') unless paymentMethod

      paymentMethod.id

  service
