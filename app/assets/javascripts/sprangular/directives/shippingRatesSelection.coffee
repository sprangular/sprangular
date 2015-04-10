Sprangular.directive 'shippingRateSelection', ->
  restrict: 'E'
  templateUrl: 'shipping/rates.html'
  scope:
    order: '='
    disabled: '='

  controller: ($scope, Checkout, Env, _) ->
    $scope.loading = false
    $scope.address = {}
    $scope.currencySymbol = Env.currency.symbol

    $scope.$watch 'order.shippingRate', (rate, oldRate) ->
      return if !oldRate || !rate || (rate.shippingMethodId == oldRate.shippingMethodId && rate.cost == oldRate.cost)

      order = $scope.order
      order.shipTotal = rate.cost

      order.updateTotals()

      Checkout.setDelivery()

    $scope.$watch('order.shippingAddress', ->
      $scope.address = $scope.order.shippingAddress
    , true)

  link: (element, attrs) ->
    attrs.disabled = false unless attrs.disabled?
