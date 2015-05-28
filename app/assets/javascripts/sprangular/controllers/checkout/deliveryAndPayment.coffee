Sprangular.controller 'CheckoutDeliveryAndPaymentCtrl', ($scope, Account, Cart, Checkout, Flash) ->
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

    # no need to create new credit card if we also have a valid one
    order.creditCard = new Sprangular.CreditCard unless creditCard.id? || order.creditCard.isValid()
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
          Cart.current.loading = false
          $scope.processing = false
          Flash.error('There has been an error processing your payment, please double check your credit card information.')

