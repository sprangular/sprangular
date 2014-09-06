Sprangular.service "Status", ($rootScope) ->

  status =
    initialized: false
    pageTitle: "Home"
    bodyClass: "default"
    requestedPath: null
    httpLoading: false
    routeChanging: false

    isLoading: ->
      @httpLoading || @routeChanging

  $rootScope.$watch (-> status.isLoading()), (loading) ->
    event = if loading then 'start' else 'end'
    $rootScope.$broadcast("loading.#{event}")

  status
