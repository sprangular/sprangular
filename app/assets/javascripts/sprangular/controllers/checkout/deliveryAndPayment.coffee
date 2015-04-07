Sprangular.controller 'CheckoutDeliveryAndPaymentCtrl', ($scope, Account, Cart, Checkout) ->
  $scope.order = Cart.current
  $scope.processing = false
  $scope.user = Account.user

  $scope.advance = ->
    order = $scope.order
    return if order.shippingAddress.isInvalid() || (!order.billToShipAddress && order.billingAddress.isInvalid())

    $scope.processing = true

    Checkout.setPayment()
      .then ->
          $scope.processing = false
        , ->
          $scope.processing = false
