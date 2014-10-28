Sprangular.controller "CartCtrl", ($scope, Cart, Status, Angularytics) ->

  $scope.cart = Cart.current
  $scope.status = Status

  $scope.removeItem = (item) ->
    Angularytics.trackEvent("Cart", "Item removed", item.variant.product.name)
    Cart.removeItem item

  $scope.isEmpty = ->
    Cart.current.isEmpty()

  $scope.empty = ->
    Cart.empty()
    Angularytics.trackEvent("Cart", "Emptied")
    $scope.$emit('cart.empty', Cart)

  $scope.reload = ->
    Cart.reload()
