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
  $scope.shippingAddress = {}
  $scope.billingAddress = {}
  $scope.shippingValid = false
  $scope.billingValid = false
  $scope.isValid = false
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

  $scope.validateShipping = ->
    $scope.shippingValid = !!$scope.shippingAddress.firstname && !!$scope.shippingAddress.lastname && !!$scope.shippingAddress.city && !!$scope.shippingAddress.address1 && !!$scope.shippingAddress.zipcode && !!$scope.shippingAddress.country.id && !!$scope.shippingAddress.state.id && !!$scope.shippingAddress.phone

  $scope.validateBilling = ->
    $scope.billingValid = !!$scope.billingAddress.firstname && !!$scope.billingAddress.lastname && !!$scope.billingAddress.city && !!$scope.billingAddress.address1 && !!$scope.billingAddress.zipcode && !!$scope.billingAddress.country.id && !!$scope.billingAddress.state.id && !!$scope.billingAddress.phone

  $scope.sendAddresses = ->
    $scope.shippingAddress = $scope.order.shippingAddress
    $scope.billingAddress = $scope.order.billingAddress
    $scope.isValid = $scope.validateBilling() && $scope.validateShipping()

    if($scope.isValid)
      $scope.loading = true
      Checkout.update('payment').then ->
        $scope.loading = false
    else
      $scope.order.shippingRates = []