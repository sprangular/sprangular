Sprangular.controller 'CheckoutDeliveryAndPaymentCtrl', ($scope, Account, Cart, Checkout) ->
  $scope.order = Cart.current
  $scope.processing = false
  $scope.user = Account.user

  $scope.$watch 'order.state', (state) ->
    $scope.done = state == 'confirm'
    $scope.active = _.contains(['delivery', 'payment'], state)

  $scope.advance = ->
    order = $scope.order
    return if order.shippingAddress.isInvalid() || (!order.billToShipAddress && order.billingAddress.isInvalid())

    $scope.processing = true

    Checkout.setPayment()
      .then ->
          $scope.processing = false
        , ->
          $scope.processing = false
