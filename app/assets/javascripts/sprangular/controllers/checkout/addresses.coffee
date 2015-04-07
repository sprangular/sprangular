Sprangular.controller 'CheckoutAddressesCtrl', ($scope, Account, Cart, Checkout, Geography) ->
  Geography.getCountryList().then (countries) ->
    $scope.countries = countries

  $scope.order = Cart.current
  $scope.processing = false
  $scope.user = Account.user

  $scope.advance = ->
    order = $scope.order
    return if order.shippingAddress.isInvalid() || (!order.billToShipAddress && order.billingAddress.isInvalid())

    $scope.processing = true

    Checkout.setAddresses()
      .then ->
          $scope.processing = false
        , ->
          $scope.processing = false
