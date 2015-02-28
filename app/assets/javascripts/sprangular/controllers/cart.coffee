Sprangular.controller "CartCtrl", (
  $scope,
  Cart,
  Account,
  Status,
  Angularytics,
  Env
) ->

  $scope.user = Account.user
  $scope.cart = Cart.current
  $scope.status = Status
  $scope.currencySymbol = Env.config.currency.symbol

  $scope.removeAdjustment = (adjustment) ->
    Angularytics.trackEvent("Cart", "Coupon removed", adjustment.promoCode())
    Cart.removeAdjustment(adjustment)

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
