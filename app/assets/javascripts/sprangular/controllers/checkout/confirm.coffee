Sprangular.controller 'CheckoutConfirmCtrl', ($scope, $location, order, Account, Cart, Checkout) ->
  $scope.order = order
  $scope.processing = false

  $scope.complete = ->
    $scope.processing = true

    Checkout.complete()
      .success -> $location.path('/checkout/complete')
      .error   -> $location.path('/checkout')
