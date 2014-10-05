Sprangular.controller 'CheckoutConfirmCtrl', ($scope, $location, order, Account, Cart, Checkout) ->
  $scope.order = order

  $scope.complete = ->
    $location.path('/checkout/complete')
