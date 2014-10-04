Sprangular.controller 'CheckoutConfirmCtrl', ($scope, $location, Account, Cart, Checkout) ->
  $scope.complete = ->
    $location.path('/checkout/complete')
