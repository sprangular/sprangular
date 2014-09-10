Sprangular.service "Cart", ($q, $http, _, Catalog) ->

  service =

    clear: ->
      @items = []
      @number = null
      @totalPrice = 0

    reload: ->
      service.clear()

      $http.get '/api/cart.json'
        .success(@load)

    load: (data) ->
      service.clear()
      service.number = data.number
      service.totalPrice = data.total

      for item in data.line_items
        variant = Sprangular.extend(item.variant, Sprangular.Variant)

        service.items.push(variant: variant, quantity: item.quantity, price: item.price)

    isEmpty: ->
      @items.length == 0

    totalQuantity: ->
      @items.reduce ((total, item) -> total + item.quantity), 0

    empty: ->
      $http.delete '/api/cart'
        .success(@load)

    addVariant: (variant, quantity) ->
      foundProducts = @findVariant(variant.id)

      if foundProducts.length > 0
        @changeItemQuantity(foundProducts[0], quantity)
      else
        @items.push(variant: variant, quantity: quantity, price: variant.price)

        params = $.param(variant_id: variant.id, quantity: quantity)

        $http.post '/api/cart/add_variant', params
          .success(@load)

    findVariant: (variantId) ->
      item for item in @items when item.variant.id is variantId

    hasVariant: (variant) ->
      variant && @findVariant(variant.id).length > 0

    removeItem: (item) ->
      i = @items.indexOf item
      @items.splice(i, 1) unless i is -1
      @updateItemQuantity item.variant.id, 0

    changeItemQuantity: (item, delta) ->
      oldQuantity = item.quantity
      item.quantity += delta
      item.quantity = 0 if item.quantity < 0

      if item.quantity != oldQuantity
        @updateItemQuantity(item.variant.id, item.quantity)

    updateItemQuantity: (id, quantity) ->
      params = $.param(variant_id: id, quantity: quantity)

      $http.put '/api/cart/update_variant', params
        .success(@load)


  service.reload()
  service
