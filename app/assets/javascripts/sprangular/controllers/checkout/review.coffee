Sprangular.controller 'CheckoutReviewCtrl', ($scope, $location, Cart, Checkout) ->
  $scope.order = Cart.current

  $scope.$watch 'order.state', (state) ->
    $scope.active = (state == 'confirm')

  $scope.placeOrder = ->
    $scope.processing = true

    if $scope.order.isInvalid()
      $scope.processing = false
      return

    Checkout.confirm()
      .then (order) ->
          if order.errors && Object.keys(orders.errors).length > 0
            $scope.processing = false
          else
            $location.path('/checkout/complete')
        , ->
          $scope.processing = false
