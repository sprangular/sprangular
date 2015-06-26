Sprangular.controller 'CheckoutAddressesCtrl', ($scope, Account, Cart, Checkout, Geography, Flash) ->
  Geography.getCountryList().then (countries) ->
    $scope.countries = countries

  $scope.order = Cart.current
  $scope.processing = false
  $scope.user = Account.user
  $scope.submitted = false

  unless Account.isGuest
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
    $scope.submitted = true

    return if order.shippingAddress.isInvalid() || (!order.billToShipAddress && order.billingAddress.isInvalid())

    $scope.processing = true

    Checkout.setAddresses()
      .then ->
          createMergedAddressList()
          $scope.processing = false
          $scope.submitted = false
        , ->
          Cart.current.loading = false
          $scope.processing = false
          
          # show descriptive error
          if Cart.current.errors.base
            Flash.error(Cart.current.errors.base)
          else
            errors = []
            for k, v of Cart.current.shippingAddress.errors
              errors.push 'Shipping address ' + k + ' ' + v[0]
            for k, v of Cart.current.billingAddress.errors
              errors.push 'Billing address ' + k + ' ' + v[0]
            
            Flash.error(errors.join(' , '))

