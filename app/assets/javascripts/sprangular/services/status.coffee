Sprangular.service "Status", ($rootScope) ->

  status =
    initialized: false
    pageTitle: "Home"
    bodyClasses: {default: true}
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

    addBodyClass: (klass) ->
      @bodyClasses[klass] = true

    toggleBodyClass: (klass) ->
      @bodyClasses[klass] = !@bodyClasses[klass]

  $rootScope.$on '$routeChangeSuccess', ->
    status.bodyClasses = {default: true}

  $rootScope.$watch (-> status.isLoading()), (loading) ->
    event = if loading then 'start' else 'end'
    $rootScope.$broadcast("loading.#{event}")

  status
