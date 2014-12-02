Sprangular.controller 'CheckoutConfirmCtrl', ($scope, $location, order, Account, Cart, Checkout) ->
  $scope.order = order
  $scope.processing = false

  $scope.complete = ->
    $scope.processing = true

    success = ->
      Cart.init()
      Account.init()
      $location.path('/checkout/complete')

    error = ->
      $location.path('/checkout')

    Checkout.finalize().then(success, error)
