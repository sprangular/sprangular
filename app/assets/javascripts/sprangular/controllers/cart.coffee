Sprangular.controller "CartCtrl", ($scope, $state, Cart, Status) ->

  $scope.cart = Cart
  $scope.status = Status

  $scope.removeItem = (item) ->
    Cart.removeItem item

  $scope.isEmpty = ->
    Cart.isEmpty()

  $scope.empty = ->
    Cart.empty()

  $scope.incrementItem = (item) ->
    Cart.changeItemQuantity item, +1

  $scope.decrementItem = (item) ->
    Cart.changeItemQuantity item, -1

  $scope.reload = ->
    Cart.reload()

  $scope.toggleCart = ->
    Status.bodyState = if Status.bodyState is "is-drw--open is-cart--open" then "" else "is-drw--open is-cart--open"
