Sprangular.controller 'CheckoutCtrl', ($scope, $location, countries, order, Account, Cart, Checkout) ->
  $scope.countries = countries
  $scope.order = order

  $scope.submit = ->
    $location.path('/checkout/confirm')
