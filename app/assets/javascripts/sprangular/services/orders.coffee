Sprangular.service "Orders", ($http) ->

  service =
    find: (number) ->
      $http.get("/api/orders/#{number}")
        .then (response) ->
          Sprangular.extend(response.data, Sprangular.Order)

  service
