Sprangular.service "Orders", ($http) ->

  service =
    find: (number, token) ->
      config =
        headers:
          'X-Spree-Order-Token': token

      $http.get("api/orders/#{number}", config)
        .then (response) ->
          service._loadOrder(response.data)

    all: ->
      $http.get("api/orders")
        .then (response) ->
          _.map response.data, (record) ->
            service._loadOrder(record)

    _loadOrder: (data) ->
      order = new Sprangular.Order
      order.load(data)

  service
