Sprangular.controller 'CheckoutAddressesCtrl', ($scope, Account, Cart, Checkout, Geography) ->
  Geography.getCountryList().then (countries) ->
    $scope.countries = countries

  $scope.order = Cart.current
  $scope.processing = false
  $scope.user = Account.user

  $scope.shippingAddresses = $scope.user.addresses.slice()
  $scope.billingAddresses = $scope.user.addresses.slice()

  $scope.$watch 'order.state', (state) ->
    $scope.done = _.contains(['confirm', 'payment', 'delivery'], state)
    $scope.active = _.contains(['cart', 'address'], state)

  createMergedAddressList = ->
    addresses = $scope.user.addresses
    order = $scope.order

    _.each $scope.shippingAddresses, (address, index) ->
      if address.same(order.shippingAddress)
        $scope.shippingAddresses[index] = order.shippingAddress

    _.each $scope.billingAddresses, (address, index) ->
      if address.same(order.billingAddress)
        $scope.billingAddresses[index] = order.billingAddress

  createMergedAddressList()

  $scope.edit = ->
    $scope.order.state = 'address'

  $scope.advance = ->
    order = $scope.order
    return if order.shippingAddress.isInvalid() || (!order.billToShipAddress && order.billingAddress.isInvalid())

    $scope.processing = true

    Checkout.setAddresses()
      .then ->
          createMergedAddressList()
          $scope.processing = false
        , ->
          $scope.processing = false
