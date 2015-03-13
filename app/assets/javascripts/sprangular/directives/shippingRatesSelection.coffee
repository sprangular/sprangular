Sprangular.directive 'shippingRateSelection', ->
  restrict: 'E'
  templateUrl: 'shipping/rates.html'
  scope:
    order: '='

  controller: ($rootScope, $scope, Checkout, Env) ->
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
      $scope.isValid = address.name && address.city && address.address1 && address.zipcode && address.country && address.state && address.phone

    $scope.$watch('address', validateAddress, true)

    # use $scope.$watchGroup when its released
    $scope.$watch 'address.name + address.country.id + address.state.id + address.zipcode + address.phone + isValid', (oldValue, newValue) ->
      return if $scope.loading 
      return if $scope.order.shippingRates.length > 0 && (oldValue == newValue || !$scope.isValid) 

      $rootScope.$broadcast('addressSelection.editing')                    

    validateAddress($scope.address)
