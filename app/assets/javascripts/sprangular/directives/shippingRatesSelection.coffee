Sprangular.directive 'shippingRateSelection', ->
  restrict: 'E'
  templateUrl: 'shipping/rates.html'
  scope:
    order: '='
  controller: ($scope) ->
    $scope.rates = [
      {id: 1, name: 'Standard', rate: 0},
      {id: 2, name: '2 Day Air', rate: 10.45},
      {id: 3, name: 'Next Day Air', rate: 29.20}
    ]
