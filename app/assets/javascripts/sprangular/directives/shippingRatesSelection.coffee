Sprangular.directive 'shippingRateSelection', ->
  restrict: 'E'
  templateUrl: 'shipping/rates.html'
  scope:
    order: '='
  controller: ($scope) ->
    $scope.rates = [
      {shippingMethodId: 1, name: 'Standard', cost: 0},
      {shippingMethodId: 2, name: '2 Day Air', cost: 10.45},
      {shippingMethodId: 3, name: 'Next Day Air', cost: 29.20}
    ]
