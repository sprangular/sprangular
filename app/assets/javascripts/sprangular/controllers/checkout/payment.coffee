CheckoutPaymentCtrl = ($scope, Account, Cart, Checkout, Flash) ->
  $scope.order = Cart.current
  $scope.processing = false
  $scope.user = Account.user
  $scope.submitted = false

  $scope.$watch 'order.state', (state) ->
    $scope.done = state is 'confirm'
    $scope.active = state is 'payment'

  $scope.edit = ->
    order = $scope.order
    creditCard = order.creditCard

    # no need to create new credit card if we also have a valid one
    order.creditCard = new Sprangular.CreditCard unless creditCard.id? || order.creditCard.isValid()
    order.state = 'payment'

  $scope.advance = ->
    order = $scope.order
    $scope.submitted = true

    return unless order.creditCard.id? || order.creditCard.isValid()

    $scope.processing = true

    success = ->
      $scope.processing = false
      $scope.submitted = false

    failure = ->
      Cart.current.loading = false
      $scope.processing = false
      if Cart.current.errors.base
        prefixMsg = if Array.isArray(Cart.current.errors.base) then '' else 'Your card '
        Flash.error(prefixMsg + Cart.current.errors.base) 
      else
        Flash.error('There has been an error processing your payment, please double check your credit card information.')

    Checkout.setPayment().then(success, failure)

Sprangular.controller 'CheckoutPaymentCtrl', CheckoutPaymentCtrl
