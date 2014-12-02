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
        sourceParams.cc_type = card.type
        sourceParams.verification_value = card.cvc
        sourceParams.month = card.month
        sourceParams.year = card.year
        sourceParams.last_digits = card.lastDigits
        sourceParams.name = order.billingAddress.fullName()

        params.payment_source[paymentMethodId] = sourceParams

      @put(params)
        .success (data) ->
          Cart.lastOrder = Sprangular.extend(data, Sprangular.Order)
          Account.reload().then ->
            Cart.init()

    put: (params) ->
      params ||= {}
      path ||= ''

      $http.put("/spree/api/checkouts/#{Cart.current.number}/#{path}", $.param(params))
           .success (response) ->
             Cart.load(response) unless response.error
           .error (response) ->
             Cart.errors(response.errors)

  service
