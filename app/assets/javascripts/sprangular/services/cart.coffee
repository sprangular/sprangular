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
      order = service.current
      order.clear()
      order.number = data.number
      order.state = data.state
      order.itemTotal = Number(data.item_total)
      order.taxTotal = Number(data.tax_total)
      order.shipTotal = Number(data.ship_total)
      order.adjustmentTotal = Number(data.adjustment_total)
      order.total = Number(data.total)
      order.shipToBillAddress = data.use_billing
      order.adjustments = Sprangular.extend(data.adjustments, Sprangular.Adjustment)

      if data.bill_address
        order.billingAddress = Sprangular.extend(data.bill_address, Sprangular.Address)

      if data.ship_address
        order.shippingAddress = Sprangular.extend(data.ship_address, Sprangular.Address)

      products = Sprangular.extend(data.products, Sprangular.Product)

      for item in data.line_items
        for product in products
          variant = product.findVariant(item.variant_id)
          break if variant

        order.items.push(variant: variant, quantity: item.quantity, price: item.price)

      order

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

      $http.get('/api/shipping_rates', {params: params, class: Sprangular.ShippingRate})

    clear:                   -> @current.clear()
    totalQuantity:           -> @current.totalQuantity()
    findVariant: (variantId) -> @current.findVariant(variantId)
    hasVariant: (variant)    -> @current.hasVariant(variant)
    isEmpty:                 -> @current.isEmpty()

  service.clear()
  service.reload()
  service
