Sprangular.controller 'CheckoutCtrl', (
  $scope,
  $location,
  countries,
  order,
  Status,
  Account,
  Cart,
  Checkout,
  Angularytics,
  Env,
  Flash,
  $translate
) ->
  Status.setPageTitle('checkout.checkout')

  user = Account.user

  $scope.countries = countries
  $scope.order = order
  $scope.processing = false
  $scope.user = user
  $scope.secure = $location.protocol() == 'https'
  $scope.currencySymbol = Env.currency.symbol

  Cart.lastOrder = null

  order.resetAddresses(user)
  order.resetCreditCard(user)

  $scope.removeAdjustment = (adjustment) ->
    Angularytics.trackEvent("Cart", "Coupon removed", adjustment.promoCode())
    Cart.removeAdjustment(adjustment)

  $scope.complete = ->
    $scope.processing = true

    if $scope.order.isInvalid()
      Flash.error("Please correct the errors on your form.")
      $scope.processing = false
      return

    Checkout.complete()
      .error   -> $location.path('/checkout')
      .success ->
        $location.path('/checkout/complete')
