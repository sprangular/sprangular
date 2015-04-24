Sprangular.controller 'CheckoutCtrl', (
  $scope,
  $location,
  countries,
  order,
  user,
  Status,
  Account,
  Cart,
  Checkout,
  Flash,
  Angularytics,
  Env,
  $translate
) ->
  Status.setPageTitle('checkout.checkout')

  $scope.order = order
  $scope.secure = $location.protocol() == 'https'
  $scope.currencySymbol = Env.currency.symbol
  $scope.shippingAddress = {}
  $scope.billingAddress = {}
  $scope.shippingValid = false
  $scope.billingValid = false
  $scope.isValid = false
  Cart.lastOrder = null

  removeUnavailableVariants = ->
    _.each Cart.unavailableItems(), (item) ->
      $translate('cart.out_of_stock', name: item.variant.product.name).then (message) ->
        Flash.error(message)

      Cart.removeItem(item).then ->
        if Cart.isEmpty()
          $location.path("/")

  removeUnavailableVariants()

  if !Account.isGuest
    $scope.user = user
    order.resetAddresses(user)
    order.resetCreditCard(user)
  else
    $scope.user = user = {}

  $scope.removeAdjustment = (adjustment) ->
    Angularytics.trackEvent("Cart", "Coupon removed", adjustment.promoCode())
    Cart.removeAdjustment(adjustment)
