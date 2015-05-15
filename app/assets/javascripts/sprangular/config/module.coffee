# Main Module
window.Sprangular = angular.module('Sprangular', [
  'ngRoute'
  'ngAnimate'
  'underscore'
  'ngSanitize'
  'mgcrea.ngStrap'
  'angularytics'
  'pascalprecht.translate'
])

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
