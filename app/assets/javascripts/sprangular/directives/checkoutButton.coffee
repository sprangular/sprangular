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
      $scope.allowOneClick = user.allowOneClick

    $scope.standardCheckout = ->
      $scope.processing = true
      $location.path("/checkout")

    $scope.oneClickCheckout = ->
      $scope.processing = true

      order = Cart.current
      user = $scope.user

      order.resetAddresses(user)
      order.resetCreditCard(user)

      Checkout.update('payment')
        .success ->
          $location.path('/checkout/confirm')
        .error ->
          $location.path('/checkout')

    $scope.checkout = ->
      if $scope.allowOneClick
        $scope.oneClickCheckout()
      else
        $scope.standardCheckout()
