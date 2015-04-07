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

  user = Account.user

  $scope.order = order
  $scope.secure = $location.protocol() == 'https'
  $scope.currencySymbol = Env.currency.symbol

  Cart.lastOrder = null

  order.resetAddresses(user)
  order.resetCreditCard(user)

  $scope.removeAdjustment = (adjustment) ->
    Angularytics.trackEvent("Cart", "Coupon removed", adjustment.promoCode())
    Cart.removeAdjustment(adjustment)
