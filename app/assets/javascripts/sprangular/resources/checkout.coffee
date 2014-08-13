Sprangular.service "Checkout", ($q, $http, _, Account, Cart) ->

  content =
    order: [] # [{...}]
    number: null

  contentDefer = $q.defer()

  checkout =

    init: (number) ->
      $http.get "/spree/api/orders/#{number}"
        .success (data) ->
          content.order = data
          content.number = data.number
          contentDefer.resolve content
        .error (error) ->
          console.log '404'

    next: ->
      $http.put "/spree/api/checkouts/#{content.number}/next"
        .success (data) ->
          content.order = data
          content.number = data.number
          contentDefer.resolve content
        .error (error) ->
          console.log '404', error

    setShippingAddresses: (shippingAddress) ->
      params =
        order:
          ship_address_attributes: shippingAddress.serialize()
        state: 'address'
      $http.put("/spree/api/checkouts/#{content.number}", $.param params)
        .success (data) ->
          content.order = data
          contentDefer.resolve content
        .error (error) ->
          console.log '404', error

    setBillingAddresses: (billingAddress) ->
      params =
        order:
          bill_address_attributes: billingAddress.serialize()
        state: 'address'
      $http.put("/spree/api/checkouts/#{content.number}", $.param params)
        .success (data) ->
          content.order = data
          contentDefer.resolve content
        .error (error) ->
          console.log '404', error

    setDelivery: (shipment, shippingRate) ->
      params =
        'order[shipments_attributes][][id]': shipment.id
        'order[shipments_attributes][][selected_shipping_rate_id]': shippingRate.id
        'state': 'delivery'

      $http.put("/spree/api/checkouts/#{content.number}", $.param params)
        .success (data) ->
          content.order = data
          contentDefer.resolve content
        .error (error) ->
          console.log '404', error

    setPayment: (card, paymentMethodId) ->
      params =
        'order[payments_attributes][][payment_method_id]': paymentMethodId
        'state': 'payment'

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

      $http.put("/spree/api/checkouts/#{content.number}", $.param params)
        .success (data) ->
          content.order = data
          contentDefer.resolve content
        .error (error) ->
          console.log '404', error

    confirm: ->
      $http.put("/spree/api/checkouts/#{content.number}")
        .success (data) ->
          content.order = data
          Account.reload()
          contentDefer.resolve content
        .error (error) ->
          console.log '404', error

    fetchContent: ->
      return contentDefer.promise

  checkout