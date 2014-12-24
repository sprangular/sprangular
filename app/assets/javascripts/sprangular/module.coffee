# Main Module
window.Sprangular = angular.module "Sprangular", ['ui.bootstrap', 'ngRoute', 'ngResource', 'ngAnimate', 'underscore', 'ngSanitize', 'rawFilter', 'mgcrea.ngStrap', 'infinite-scroll', 'angularytics']
  .run (Env) ->
    paymentMethods = Env.config.payment_methods

    if paymentMethods.length == 0
      alert 'Gateway is not configured in Spree...'

Sprangular.routeDefs = []
Sprangular.defineRoutes = (fn) ->
  Sprangular.routeDefs.push(fn)

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
Sprangular.config ["$httpProvider", "$locationProvider", ($httpProvider, $locationProvider) ->
  $httpProvider.defaults.headers.common['Accept'] = 'application/json'
  $httpProvider.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded'
  $httpProvider.defaults.headers.put['Content-Type'] = 'application/x-www-form-urlencoded'

  $locationProvider
    .html5Mode false
    .hashPrefix '!'
]

Sprangular.run ($rootScope, $location, Status, Account, Cart, Flash) ->

  $rootScope.$on '$routeChangeStart', (event, next, current) ->
    requirements = next.requires || {}
    Status.routeChanging = true

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
    alert "Error changing route #{rejection}"

  Account.init()
    .success -> Status.initialized = true
    .error -> Status.initialized = true
