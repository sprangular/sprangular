Sprangular.service "Status", ($rootScope, $translate) ->

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

    cacheProduct: (product) ->
      status.cachedProducts.push(product)

    cacheProducts: (list) ->
      status.cachedProducts = status.cachedProducts.concat(list)

    findCachedProduct: (slug) ->
      console.log status.cachedProducts
      _.find status.cachedProducts, (product) ->
        product.slug == slug

    setPageTitle: (translation_key) ->
      $translate(translation_key).then (text) ->
        status.pageTitle = text

    # addBodyClass('open', 'focused')
    addBodyClass: ->
      @_eachClass arguments, (classes, klass) ->
        classes[klass] = true

    # removeBodyClass('open', 'focused')
    removeBodyClass: ->
      @_eachClass arguments, (classes, klass) ->
        classes[klass] = false

    # toggleBodyClass('open', 'focused')
    toggleBodyClass: ->
      @_eachClass arguments, (classes, klass) ->
        classes[klass] = !classes[klass]

    _eachClass: (args, fn) ->
      self = this
      _.each args, (klass) -> fn(self.bodyClasses, klass)

  $rootScope.$on '$routeChangeSuccess', ->
    status.bodyClasses = {default: true}

  $rootScope.$watch (-> status.isLoading()), (loading) ->
    if loading
      status.addBodyClass('loading')
      $rootScope.$broadcast("loading.start")
    else
      status.removeBodyClass('loading')
      $rootScope.$broadcast("loading.end")

  status
