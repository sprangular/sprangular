Sprangular.controller 'CheckoutShippingCtrl', ($scope, $state, Account, Cart, Checkout, Product, Address, _) ->

  $scope.addresses = null
  $scope.newAddress = null
  $scope.states = Address.getStatesList()
  $scope.selectedAddress = null
  $scope.addingNewAddress= false

  Checkout.fetchContent().then (content) ->
    Account.fetch().then (account) ->
      $scope.addresses = account.shippingAddresses
      if content.order.ship_address
        console.log content.order.ship_address
        orderShippingAddress = Address.load content.order.ship_address
        for item in $scope.addresses
          if orderShippingAddress.equals(item)
            $scope.selectedAddress = item
        if $scope.selectedAddress == null
          $scope.addingNewAddress = true
          $scope.newAddress = orderShippingAddress
          $scope.selectedAddress = $scope.newAddress
      else
        if $scope.addresses.length > 0
          $scope.selectedAddress = $scope.addresses[0]
        else
          $scope.enterNewAddress()

  $scope.useAddress = (address) ->
    $scope.selectedAddress = address

  $scope.enterNewAddress = ->
    $scope.newAddress = new Address()
    $scope.addingNewAddress = true
    $scope.selectedAddress = $scope.newAddress

  $scope.addNewAddress = ->
    $scope.addresses.push $scope.newAddress
    $scope.addingNewAddress = false

  $scope.advance = ->
    Checkout.setShippingAddresses($scope.selectedAddress).then (content) ->
      Checkout.fetchContent().then (content) ->
        console.log 'Checkout.fetchContent().then (content) ->', content
        $scope.refreshContent()
        $state.go 'checkout.billing'
