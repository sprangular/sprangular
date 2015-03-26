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
  $translate
) ->
  Status.setPageTitle('checkout.checkout')

  $scope.countries = countries
  $scope.order = order
  $scope.processing = false
  $scope.secure = $location.protocol() == 'https'
  $scope.currencySymbol = Env.currency.symbol
  Cart.lastOrder = null

  if !Account.isGuest
    $scope.user = user = Account.user
    order.resetAddresses(user)
    order.resetCreditCard(user)
  else
    $scope.user = user = {}

  $scope.removeAdjustment = (adjustment) ->
    Angularytics.trackEvent("Cart", "Coupon removed", adjustment.promoCode())
    Cart.removeAdjustment(adjustment)

  $scope.complete = ->
    $scope.processing = true

    if $scope.order.isInvalid()
      $scope.processing = false
      return

    Checkout.complete()
      .error   -> $location.path('/checkout')
      .success ->
        $location.path('/checkout/complete')
