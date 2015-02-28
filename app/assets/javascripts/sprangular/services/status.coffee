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

    cacheProducts: (list) ->
      status.cachedProducts = status.cachedProducts.concat(list)

    findCachedProduct: (slug) ->
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
    event = if loading then 'start' else 'end'
    $rootScope.$broadcast("loading.#{event}")

  status
