Sprangular.directive 'shippingRateSelection', ->
  restrict: 'E'
  templateUrl: 'shipping/rates.html'
  scope:
    order: '='

  controller: ($scope, Checkout, Env) ->
    $scope.loading = false
    $scope.address = {}
    $scope.currencySymbol = Env.config.currency.symbol

    $scope.$watch 'order.shippingRate', (rate, oldRate) ->
      return if !oldRate || rate.id == oldRate.id

      order = $scope.order

      if rate
        order.shipTotal = rate.cost
      else
        order.shipTotal = 0

      order.updateTotals()

    $scope.$watch('order.actualShippingAddress()', ->
      $scope.address = $scope.order.actualShippingAddress()
    , true)

    validateAddress = (address) ->
      $scope.isValid = address.firstname && address.lastname && address.city && address.address1 && address.zipcode && address.country && address.state && address.phone

    $scope.$watch('address', validateAddress, true)

    validateAddress($scope.address)
