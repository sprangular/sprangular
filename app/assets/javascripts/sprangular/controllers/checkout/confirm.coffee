Sprangular.controller 'CheckoutConfirmCtrl', ($scope, $location, order, Account, Cart, Checkout) ->
  $scope.order = order
  $scope.processing = false

  $scope.complete = ->
    $scope.processing = true

    Checkout.complete()
      .error   -> $location.path('/checkout')
      .success ->
        order = $scope.order
        ga "ecommerce:addTransaction",
          id:       order.number
          revenue:  order.total
          shipping: order.shipTotal
          tax:      order.taxTotal

        for item in order.items
          ga "ecommerce:addItem",
            id:       order.number
            name:     item.variant.name
            sku:      item.variant.sku
            price:    item.price
            quantity: item.quantity

        ga "ecommerce:send"

        $location.path('/checkout/complete')
