Sprangular.factory 'Newsletter', ($http) ->

  subscribe: (email) ->
    params =
      chimpy_subscriber:
        email: email
        subscribed: true

    $http.post("/spree/subscribers", $.param(params), { ignoreLoadingIndicator: true })
