'use strict'

Sprangular.directive 'checkoutButton', ->
  restrict: 'E'
  scope:
    user: '='
  templateUrl: 'directives/checkout_button.html'
  controller: ($scope, $location, Cart, Checkout) ->
    $scope.processing = false

    $scope.checkout = ->
      $scope.processing = true
      $location.path("/checkout")
