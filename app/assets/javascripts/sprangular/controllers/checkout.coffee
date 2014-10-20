Sprangular.controller 'CheckoutCtrl', ($scope, $location, countries, order, Account, Cart, Checkout) ->
  $scope.countries = countries
  $scope.order = order
  $scope.processing = false

  $scope.order.resetCreditCard()

  $scope.submit = ->
    $scope.processing = true

    if $scope.order.isInvalid()
      $scope.processing = false
      return

    Checkout.update()
      .success ->
        $location.path('/checkout/confirm')
      .error ->
        $scope.processing = false
