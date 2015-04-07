Sprangular.service "Orders", ($http) ->

  service =
    find: (number) ->
      $http.get("/api/orders/#{number}")
        .then (response) ->
          order = new Sprangular.Order
          order.load(response.data)

  service
