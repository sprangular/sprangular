Sprangular.directive 'shippingRateSelection', ->
  restrict: 'E'
  templateUrl: 'shipping/rates.html'
  scope:
    order: '='
  controller: ($scope, Cart, Checkout) ->
    $scope.hasLocationData = false
    $scope.loading = false
    $scope.rates = []

    $scope.$watch 'order.shippingRate', (rate, oldRate) ->
      return if !oldRate || rate.id == oldRate.id

      order = $scope.order

      if rate
        order.shipTotal = rate.cost
      else
        order.shipTotal = 0

      order.updateTotals()

    # use $scope.$watchGroup when its released
    $scope.$watch 'order.actualShippingAddress().country.id + order.actualShippingAddress().state.id + order.actualShippingAddress().zipcode', (oldValue, newValue) ->
      return if $scope.loading || !newValue || oldValue == newValue

      $scope.loading = true
      order = $scope.order
      address = order.actualShippingAddress()
      $scope.hasLocationData = address.state && address.country && address.zipcode

      Cart.shippingRates({countryId: address.countryId, stateId: address.stateId, zipcode: address.zipcode})
          .then (->
            $scope.rates = Cart.current.shippingRates

            $scope.loading = false), (->

            $scope.rates = []
            $scope.loading = false)
