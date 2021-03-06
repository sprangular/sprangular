Sprangular.controller 'CheckoutDeliveryAndPaymentCtrl', ($scope, Account, Cart, Checkout) ->
  $scope.order = Cart.current
  $scope.processing = false
  $scope.user = Account.user
  $scope.submitted = false

  $scope.$watch 'order.state', (state) ->
    $scope.done = state == 'confirm'
    $scope.active = _.contains(['delivery', 'payment'], state)

  $scope.edit = ->
    order = $scope.order
    creditCard = order.creditCard

    order.creditCard = new Sprangular.CreditCard unless creditCard.id?
    order.state = 'delivery'

  $scope.advance = ->
    order = $scope.order
    $scope.submitted = true

    return unless order.creditCard.id? || order.creditCard.isValid()

    $scope.processing = true

    Checkout.setDeliveryAndPayment()
      .then ->
          $scope.processing = false
          $scope.submitted = false
        , ->
          $scope.processing = false
