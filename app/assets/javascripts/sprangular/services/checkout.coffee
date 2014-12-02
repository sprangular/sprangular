Sprangular.service "Checkout", ($http, $q, _, Env, Account, Cart) ->

  service =
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

    finalize: ->
      paymentMethodId = Env.config.payment_methods['gateway'].id
      params =
        order:
          payment_attributes:
            payment_method_id: paymentMethodId
          payment_source: {}

      order = Cart.current
      card = order.creditCard

      if card.id
        params.order.use_existing_card = 'yes'
        params.order.existing_card = card.id
      else
        params.order.use_existing_card = 'no'
        sourceParams = {}
        sourceParams.number = card.number
        sourceParams.verification_value = card.cvc
        sourceParams.cc_type = card.type
        sourceParams.month = card.month
        sourceParams.year = card.year
        sourceParams.last_digits = card.lastDigits
        sourceParams.name = order.billingAddress.fullName()

        params.order.payment_source[paymentMethodId] = sourceParams

      order.errors = ''

      @complete(params)

    complete: (params) ->
      deferred = $q.defer()
      @put(params, 'advance')
        .success (order) ->
          if order.completed_at != null
            deferred.resolve(order)
          else if order.state == 'confirm'
            service.put()
              .success (data) ->
                if data.state == 'confirm'
                  alert 'Could not transition order to state "complete"'
                  deferred.reject(data)
                else
                  deferred.resolve(data)
              .error (data) ->
                deferred.reject(data)
          else
            service.complete(params)
              .then(((response) -> deferred.resolve(response)),
                    ((response) -> deferred.reject(response)))

      deferred.promise

    put: (params, path) ->
      params ||= {}
      path ||= ''

      $http.put("/spree/api/checkouts/#{Cart.current.number}/#{path}", $.param(params))
           .success (response) ->
             Cart.load(response) unless response.error
           .error (response) ->
             Cart.errors(response.errors)

  service
