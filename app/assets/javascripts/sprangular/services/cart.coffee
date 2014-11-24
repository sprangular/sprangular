Sprangular.service "Cart", ($http) ->

  service =
    current: new Sprangular.Order

    reload: ->
      $http.get '/api/cart.json'
        .success(@load)

    errors: (errors) ->
      order = service.current

      order.errors = {}
      order.billingAddress.errors = {}
      order.shippingAddress.errors = {}
      order.creditCard.errors = {}

      for key, attrErrors of errors
        parts = key.split('.')

        object = parts[0]
        attr = parts[1]

        switch object
          when 'ship_address'
            order.shipingAddress.errors[attr] = attrErrors
          when 'bill_address'
            order.billingAddress.errors[attr] = attrErrors
          else
            order.errors[key] = attrErrors

    load: (data) ->
      service.current.load(data)

    empty: ->
      $http.delete '/api/cart'
        .success(@load)

    addVariant: (variant, quantity) ->
      foundProducts = @findVariant(variant.id)

      if foundProducts.length > 0
        @changeItemQuantity(foundProducts[0], quantity)
      else
        params = $.param(variant_id: variant.id, quantity: quantity)

        $http.post '/api/cart/add_variant', params, ignoreLoadingIndicator: true
          .success (response) ->
            service.load(response)

    removeItem: (item) ->
      order = service.current
      i = order.items.indexOf item
      order.items.splice(i, 1) unless i is -1
      @updateItemQuantity item.variant.id, 0

    changeItemQuantity: (item, delta) ->
      if delta != 0
        @updateItemQuantity(item.variant.id, item.quantity + delta)

    updateItemQuantity: (id, quantity) ->
      params = $.param(variant_id: id, quantity: quantity)

      $http.put '/api/cart/update_variant', params, ignoreLoadingIndicator: true
        .success(@load)

    changeVariant: (oldVariant, newVariant) ->
      params = $.param(old_variant_id: oldVariant.id, new_variant_id: newVariant.id)

      $http.put '/api/cart/change_variant', params
        .success(@load)

    removeAdjustment: (adjustment) ->
      @current.adjustmentTotal -= adjustment.amount
      @current.total -= adjustment.amount
      @current.adjustments = _.without(@current.adjustments, adjustment)

      params = $.param(adjustment_id: adjustment.id)

      $http.put '/api/cart/remove_adjustment', params
        .success(@load)

    shippingRates: (options) ->
      params =
        country_id: options.countryId
        state_id: options.stateId
        zipcode: options.zipcode

      $http.get('/api/shipping_rates', {params: params, ignoreLoadingIndicator: true, class: Sprangular.ShippingRate})

    clear:                   -> @current.clear()
    totalQuantity:           -> @current.totalQuantity()
    findVariant: (variantId) -> @current.findVariant(variantId)
    hasVariant: (variant)    -> @current.hasVariant(variant)
    isEmpty:                 -> @current.isEmpty()

  service.clear()
  service.reload()
  service
