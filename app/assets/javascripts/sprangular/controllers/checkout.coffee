Sprangular.controller 'CheckoutCtrl', ($scope, $location, countries, order, Account, Cart, Checkout) ->
  $scope.countries = countries
  $scope.order = order
  $scope.processing = false

  $scope.submit = ->
    $scope.processing = true

    Checkout.update()
      .success ->
        $location.path('/checkout/confirm')
      .error ->
        $scope.processing = false
