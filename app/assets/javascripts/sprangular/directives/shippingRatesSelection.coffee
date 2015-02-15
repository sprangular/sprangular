Sprangular.directive 'shippingRateSelection', ->
  restrict: 'E'
  templateUrl: 'shipping/rates.html'
  scope:
    order: '='

  controller: ($scope, Checkout) ->
    $scope.loading = false
    $scope.address = {}

    $scope.$watch 'order.shippingRate', (rate, oldRate) ->
      return if !oldRate || rate.id == oldRate.id

      order = $scope.order

      if rate
        order.shipTotal = rate.cost
      else
        order.shipTotal = 0

      order.updateTotals()

    $scope.$watch 'order.shipToBillAddress', ->
      $scope.address = $scope.order.actualShippingAddress()

    watchAddress = (address) ->
      $scope.isValid = address.firstname && address.lastname && address.city && address.address1 && address.zipcode && address.country && address.state && address.phone

    $scope.$watch('address', watchAddress, true)

    # use $scope.$watchGroup when its released
    $scope.$watch 'address.country.id + address.state.id + address.zipcode + isValid', (oldValue, newValue) ->
      return if $scope.loading 
      return if $scope.order.shippingRates.length > 0 && (oldValue == newValue || !$scope.isValid) 

      $scope.loading = true

      Checkout.update().then ->
        $scope.loading = false
