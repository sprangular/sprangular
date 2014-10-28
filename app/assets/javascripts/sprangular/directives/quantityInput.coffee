'use strict'

Sprangular.directive 'quantityInput', ->
  restrict: 'E'
  templateUrl: 'directives/quantity_input.html'
  scope:
    quantity: '='
    change: '&'

  controller: ($scope, Angularytics) ->
    $scope.$watch 'quantity', (newValue, oldValue)->
      if oldValue != newValue
        $scope.change()

        if oldValue > newValue
          Angularytics.trackEvent("Cart", "Quantity decrease", oldValue - newValue)
        else
          Angularytics.trackEvent("Cart", "Quantity increase", newValue - oldValue)

    $scope.update = (delta) ->
      $scope.quantity += delta unless ($scope.quantity + delta) == 0
