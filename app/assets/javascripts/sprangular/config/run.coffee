Sprangular.run (
  $rootScope,
  $location,
  $log,
  Status,
  Account,
  Cart,
  Flash,
  $cacheFactory,
  Env
) ->
  Sprangular.startupData = {}
  Status.initialized = true

  paymentMethods = Env.config.payment_methods
  if paymentMethods.length == 0
    console.error('Gateway is not configured in Spree...')

  cache = $cacheFactory.get('$http')
  if cache?
    cache.removeAll()

  $rootScope.$on '$routeChangeStart', (event, next, current) ->
    requirements = next.requires || {}
    Status.routeChanging = true
    Status.meta = {}
    redirectPath = null

    if requirements.user && !Account.isLogged
      Status.requestedPath = next.$$route.originalPath
      Flash.error('app.sign_in_or_register')
      redirectPath = '/sign-in'

    else if requirements.guest && !Account.isLogged && !Account.isGuest
      Status.requestedPath = next.$$route.originalPath
      Flash.error('app.sign_in_or_register')
      redirectPath = '/sign-in'

    else if requirements.anonymous && Account.isLogged
      Flash.error('app.must_be_logged_out')
      redirectPath = '/'

    else if requirements.cart && Cart.current.items.length == 0
      Flash.error('app.no_items_in_cart')
      redirectPath = '/'

    if redirectPath
      $location.path(redirectPath)
      Status.routeChanging = false
      event.preventDefault()

  $rootScope.$on '$routeChangeSuccess', ->
    Status.routeChanging = false

  $rootScope.$on '$routeChangeError', (event, current, previous, rejection) ->
    Status.routeChanging = false
    alert "Error changing route. See console for details."
    $log.info "Error changing route", rejection
