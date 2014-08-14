# Main Module
window.Sprangular = angular.module "Sprangular", ['ui.bootstrap', 'ngRoute', 'ngResource', 'underscore', 'ngSanitize', 'rawFilter']
  .run ->
    if PAYMENT_METHODS.stripe
      Stripe.setPublishableKey PAYMENT_METHODS.stripe.publishable_key
    else
      alert 'Stripe Payment Method is not configured in Spree...'

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
window.Sprangular.config ["$httpProvider", "$locationProvider", ($httpProvider, $locationProvider) ->
  $httpProvider.defaults.headers.common['Accept'] = 'application/json'
  $httpProvider.defaults.headers.post['Content-Type'] = 'application/x-www-form-urlencoded'
  $httpProvider.defaults.headers.put['Content-Type'] = 'application/x-www-form-urlencoded'

  $locationProvider
    .html5Mode false
    .hashPrefix '!'
]
