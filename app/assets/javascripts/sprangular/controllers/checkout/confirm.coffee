Sprangular.controller 'CheckoutConfirmCtrl', ($scope, $location, order, Account, Cart, Checkout) ->
  $scope.order = order
  $scope.processing = false

  $scope.complete = ->
    $scope.processing = true

    Checkout.complete()
      .error   -> $location.path('/checkout')
      .success ->
        $location.path('/checkout/complete')
