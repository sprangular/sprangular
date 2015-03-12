Sprangular.controller 'CheckoutReviewCtrl', ($scope, $location, Account, Cart, Checkout) ->
  $scope.order = Cart.current
  $scope.processing = false

  $scope.complete = ->
    $scope.processing = true

    Checkout.complete()
      .error   -> $location.path('/checkout')
      .success ->
        $location.path('/checkout/complete')
