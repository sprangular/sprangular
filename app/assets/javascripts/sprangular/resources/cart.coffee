Sprangular.service "Cart", ($q, $http, Catalog, _) ->

  fetchDefer = $q.defer()

  service =

    items: [] # [{variant: Z, quantity: N, price: P}]
    number: null
    totalPrice: null

    init: ->
      # Remove items from local cart (so we don't loose the data binding)
      @items.length = 0

      # Fetch cart content
      $http.get '/cart.json'
        .success (data) ->
          cartItems = data.line_items
          service.number = data.number
          service.totalPrice = data.total
          Catalog.fetch().then (catalog) ->
            for item in cartItems
              variant = catalog.findVariant { id: item.variant_id }
              service.items.push variant: variant, quantity: item.quantity, price: item.price
          fetchDefer.resolve service
        .error (error) ->

    fetch: ->
      return fetchDefer.promise

    isEmpty: ->
      @items.length == 0

    totalQuantity: ->
      @items.reduce ((total, item) -> total + item.quantity), 0

    empty: ->
      $http.delete '/cart'
        .success (data) ->
          service.items.length = 0
          service.totalPrice = 0

    reload: ->
      service.init()

    addVariant: (variant, quantity) ->
      # Check if we need to Add or Update
      foundProducts = @findVariant variant.id

      if foundProducts.length > 0
        @changeItemQuantity foundProducts[0], quantity
      else
        @items.push variant: variant, quantity: quantity, price: variant.price
        params = $.param variant_id: variant.id, quantity: quantity
        $http.post '/cart/add_variant', params
          .success (data) ->
            service.number = data.number
            service.totalPrice = data.total
            fetchDefer.resolve service

    findVariant: (variantId) ->
      item for item in @items when item.variant.id is variantId

    removeItem: (item) ->
      i = @items.indexOf item
      @items.splice(i, 1) unless i is -1
      @_updateItemQuantity item.variant.id, 0

    changeItemQuantity: (item, delta) ->
      oldQuantity = item.quantity
      item.quantity += delta
      item.quantity = 0 if item.quantity < 0

      if item.quantity != oldQuantity
        @_updateItemQuantity item.variant.id, item.quantity

    _updateItemQuantity: (id, quantity) ->
      params = $.param variant_id: id, quantity: quantity
      $http.put '/cart/update_variant', params
        .success (data) ->
          service.totalPrice = data.total
          fetchDefer.resolve service

  service.init()
  service
