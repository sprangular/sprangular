Sprangular.controller 'CheckoutDeliveryCtrl', ($scope, $location, Account, Cart, Checkout, Shipment) ->
  $scope.shipment = null
  $scope.selectedRate = null

  Account.fetch().then (account) ->
    Checkout.fetchContent().then (content) ->
      $scope.shipment = Shipment
      if content.order.shipments and content.order.shipments.length > 0
        shipment = content.order.shipments[0]
        $scope.shipment.load shipment
        if shipment.selected_shipping_rate
          $scope.selectedRate = $scope.shipment.findRate shipment.selected_shipping_rate.id

  $scope.useRate = (rate) ->
    $scope.selectedRate = rate

  $scope.advance = ->
    Checkout.setDelivery($scope.shipment, $scope.selectedRate).then (content) ->
      Checkout.fetchContent().then (content) ->
        $scope.refreshContent()
        $location.path('/checkout/payment')
