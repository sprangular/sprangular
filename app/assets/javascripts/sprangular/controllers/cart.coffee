Sprangular.controller "CartCtrl", ($scope, Cart, Status) ->

  $scope.cart = Cart
  $scope.status = Status

  $scope.removeItem = (item) ->
    Cart.removeItem item

  $scope.isEmpty = ->
    Cart.isEmpty()

  $scope.empty = ->
    Cart.empty()
    $scope.$emit('cart.empty', Cart)

  $scope.incrementItem = (item) ->
    Cart.changeItemQuantity item, +1

  $scope.decrementItem = (item) ->
    Cart.changeItemQuantity item, -1

  $scope.reload = ->
    Cart.reload()
