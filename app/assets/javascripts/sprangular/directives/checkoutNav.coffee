'use strict'

Sprangular.directive 'checkoutNav', ->
  restrict: 'E'
  templateUrl: 'checkout/nav.html'
  scope:
    step: '@'
