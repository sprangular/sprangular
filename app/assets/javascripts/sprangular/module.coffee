# Main Module
window.Sprangular = angular.module('Sprangular', [
  'ngRoute'
  'ngAnimate'
  'underscore'
  'ngSanitize'
  'mgcrea.ngStrap'
  'angularytics'
  'pascalprecht.translate'
]).run (Env) ->
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
Sprangular.config [
  '$httpProvider'
  '$locationProvider'
  '$translateProvider'
  '$logProvider'
  'Env'
  ($httpProvider, $locationProvider, $translateProvider, $logProvider, Env) ->
    $httpProvider.defaults.headers.common['Accept'] = 'application/json'
    encode_as_form = 'application/x-www-form-urlencoded'
    $httpProvider.defaults.headers.post['Content-Type'] = encode_as_form
    $httpProvider.defaults.headers.put['Content-Type'] = encode_as_form

    $locationProvider
      .html5Mode false
      .hashPrefix '!'

    $logProvider
      .debugEnabled (Env.env isnt "production")

    # i18n Support
    $translateProvider
      .translations(Env.config.locale, Env.translations)
      .fallbackLanguage(['en'])
    $translateProvider.use(Env.config.locale)
]

Sprangular.run (
  $rootScope,
  $location,
  $log,
  Status,
  Account,
  Cart,
  Flash,
  $translate
) ->
  Sprangular.startupData = {}
  Status.initialized = true

  $rootScope.$on '$routeChangeStart', (event, next, current) ->
    requirements = next.requires || {}
    Status.routeChanging = true
    Status.meta = {}

    if requirements.user && !Account.isLogged
      Status.requestedPath = next.$$route.originalPath
      Flash.error('app.sign_in_or_register')

      $location.path('/sign-in')
      event.preventDefault()

    else if requirements.guest && Account.isLogged
      Flash.error('app.must_be_logged_in')

      $location.path('/')
      event.preventDefault()

    else if requirements.cart && Cart.current.items.length == 0
      Flash.error('app.no_items_in_cart')

      $location.path('/')
      event.preventDefault()

  $rootScope.$on '$routeChangeSuccess', ->
    Status.routeChanging = false

  $rootScope.$on '$routeChangeError', (event, current, previous, rejection) ->
    Status.routeChanging = false
    alert "Error changing route. See console for details."
    $log.info "Error changing route", rejection
