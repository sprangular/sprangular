Sprangular.controller 'CheckoutCtrl', ($scope, $location, countries, order, Status, Account, Cart, Checkout, Angularytics) ->
  Status.pageTitle = 'Checkout'
  $scope.countries = countries
  $scope.order = order
  $scope.processing = false
  $scope.user = Account.user
  $scope.secure = $location.protocol() == 'https'

  Cart.lastOrder = null

  $scope.order.resetCreditCard()

  $scope.removeAdjustment = (adjustment) ->
    Angularytics.trackEvent("Cart", "Coupon removed", adjustment.promoCode())
    Cart.removeAdjustment(adjustment)

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
