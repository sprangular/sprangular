Sprangular.directive 'shippingRateSelection', ->
  restrict: 'E'
  templateUrl: 'shipping/rates.html'
  scope:
    order: '='
    isValid: '='

  controller: ($scope, Checkout, Env, _) ->
    $scope.loading = false
    $scope.address = {}
    $scope.currencySymbol = Env.currency.symbol

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
      $scope.isValid = !!address.firstname && !!address.lastname && !!address.city && !!address.address1 && !!address.zipcode && !!address.country.id && !!address.state.id && !!address.phone

    # use $scope.$watchGroup when its released
    $scope.$watch 'isValid', (oldValue, newValue) ->

      if($scope.isValid)
        $scope.loading = true

        Checkout.update('payment').then ->
          $scope.loading = false
      else
        $scope.order.shippingRates = []
    validateAddress($scope.address)

    $scope.$watch('address', validateAddress, true)
