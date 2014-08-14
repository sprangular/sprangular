Sprangular.controller 'CheckoutBillingCtrl', ($scope, $location, Account, Cart, Checkout, Address) ->

  $scope.addresses = null
  $scope.newAddress = null
  $scope.states = Address.getStatesList()
  $scope.selectedAddress = null
  $scope.addingNewAddress= false
  $scope.useShippingAddress = true
  $scope.shippingAddress = null

  Checkout.fetchContent().then (content) ->
    Account.fetch().then (account) ->
      $scope.addresses = account.billingAddresses
      $scope.shippingAddress = Address.load content.order.ship_address
      if content.order.bill_address
        billingAddress = Address.load content.order.bill_address
        if billingAddress.equals($scope.shippingAddress)
          $scope.useShippingAddress = true
        else
          $scope.useShippingAddress = false
        for item in $scope.addresses
          if billingAddress.equals(item)
            $scope.selectedAddress = item
        if $scope.selectedAddress == null
          $scope.addingNewAddress = true
          $scope.newAddress = billingAddress
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
    if $scope.useShippingAddress
      address = $scope.shippingAddress
    else
      address = $scope.selectedAddress

    Checkout.setBillingAddresses(address).then (content) ->
      Checkout.fetchContent().then (content) ->
        console.log 'Checkout.fetchContent().then (content) ->', content
        $scope.refreshContent()
        $location.path '/checkout/delivery'
