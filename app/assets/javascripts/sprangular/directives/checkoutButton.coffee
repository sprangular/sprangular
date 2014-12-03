'use strict'

Sprangular.directive 'checkoutButton', ->
  restrict: 'E'
  scope:
    user: '='
  templateUrl: 'directives/checkout_button.html'
  controller: ($scope, $location, Cart, Checkout) ->
    $scope.allowOneClick = false
    $scope.processing = false

    $scope.$watch 'user', (user) ->
      $scope.allowOneClick =
        user && user.addresses.length > 0 && user.creditCards.length > 0

    $scope.standardCheckout = ->
      $scope.processing = true
      $location.path("/checkout")

    $scope.oneClickCheckout = ->
      $scope.processing = true

      order = Cart.current
      user = $scope.user

      order.resetAddresses(user)
      order.resetCreditCard(user)

      Checkout.update()
        .success ->
          $location.path('/checkout/confirm')
        .error ->
          $location.path('/checkout')
