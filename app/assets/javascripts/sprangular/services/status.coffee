Sprangular.service "Status", ($rootScope) ->

  status =
    initialized: false
    pageTitle: "Home"
    bodyClass: "default"
    requestedPath: null
    httpLoading: false
    routeChanging: false
    cachedProducts: []
    meta: {}

    isLoading: ->
      @httpLoading || @routeChanging

    cacheProducts: (list) ->
      status.cachedProducts = status.cachedProducts.concat(list)

    findCachedProduct: (slug) ->
      _.find status.cachedProducts, (product) ->
        product.slug == slug

  $rootScope.$watch (-> status.isLoading()), (loading) ->
    event = if loading then 'start' else 'end'
    $rootScope.$broadcast("loading.#{event}")

  status
