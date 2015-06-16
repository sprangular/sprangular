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

  removeUnavailableVariants = ->
    _.each Cart.unavailableItems(), (item) ->
      $translate('cart.out_of_stock', name: item.variant.product.name).then (message) ->
        Flash.error(message)

      Cart.removeItem(item).then ->
        if Cart.isEmpty()
          $location.path("/")

  # removeUnavailableVariants()

  $scope.user = user

  if !Account.isGuest
    order.resetAddresses(user)
    order.resetCreditCard(user)

  $scope.removeAdjustment = (adjustment) ->
    Angularytics.trackEvent("Cart", "Coupon removed", adjustment.promoCode())
    Cart.removeAdjustment(adjustment)
