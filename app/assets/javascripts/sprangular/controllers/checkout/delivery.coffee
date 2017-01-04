CheckoutDeliveryCtrl = ($scope, Account, Cart, Checkout) ->
  $scope.order = Cart.current
  $scope.processing = false
  $scope.user = Account.user
  $scope.submitted = false

  $scope.$watch 'order.state', (state) ->
    $scope.done = _.include ['payment', 'confirm'], state
    $scope.active = state is 'delivery'

  $scope.edit = ->
    order = $scope.order
    creditCard = order.creditCard

    order.creditCard = new Sprangular.CreditCard unless creditCard.id?
    order.state = 'delivery'

  $scope.advance = ->
    order = $scope.order
    $scope.submitted = true
    $scope.processing = true

    success = ->
      $scope.processing = false
      $scope.submitted = false

    failure = ->
      $scope.processing = false

    Checkout.setDelivery().then(success, failure)

Sprangular.controller 'CheckoutDeliveryCtrl', CheckoutDeliveryCtrl
