# Main Module
window.Sprangular = angular.module "Sprangular", ['ui.bootstrap', 'ngRoute', 'ngResource', 'ngAnimate', 'underscore', 'ngSanitize', 'mgcrea.ngStrap', 'angularytics']
  .run (Env) ->
    paymentMethods = Env.config.payment_methods

    if paymentMethods.length == 0
      alert 'Gateway is not configured in Spree...'

Sprangular.startupData = {}

Sprangular.extend = (instance, type) ->
  return unless instance

  if instance instanceof Array
    _.map instance, (item) -> Sprangular.extend(item, type)
  else
    if typeof(type) == 'object'
      _.each type, (cls, key) ->
        instance[key] = Sprangular.extend(instance[key], cls)
      instance
    else
      newInstance = angular.extend(new type(), instance)
      newInstance.init() if newInstance.init
      newInstance

# Default Headers
Sprangular.config ["$httpProvider", "$locationProvider", ($httpProvider, $locationProvider, $logProvider) ->
  $httpProvider.defaults.headers.common['Accept'] = 'application/json'
  $httpProvider.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded'
  $httpProvider.defaults.headers.put['Content-Type'] = 'application/x-www-form-urlencoded'

  $locationProvider
    .html5Mode false
    .hashPrefix '!'

  $logProvider
    .debugEnabled (Env.env isnt "production")
]

Sprangular.run ($rootScope, $location, Status, Account, Cart, Flash) ->
  Sprangular.startupData = {}
  Status.initialized = true

  $rootScope.$on '$routeChangeStart', (event, next, current) ->
    requirements = next.requires || {}
    Status.routeChanging = true
    Status.meta = {}

    if requirements.user && !Account.isLogged
      Status.requestedPath = next.$$route.originalPath
      Flash.error('Please sign in or register to continue.')
      $location.path('/sign-in')
      event.preventDefault()

    else if requirements.guest && Account.isLogged
      Flash.error("Sorry, that page is only available when you're signed out.")
      $location.path('/')
      event.preventDefault()

    else if requirements.cart && Cart.current.items.length == 0
      Flash.error('Sorry, there are no items in your cart.')
      $location.path('/')
      event.preventDefault()

  $rootScope.$on '$routeChangeSuccess', ->
    Status.routeChanging = false

  $rootScope.$on '$routeChangeError', (event, current, previous, rejection) ->
    Status.routeChanging = false
    alert "Error changing route. See console for details."
    console?.log "Error changing route", rejection
