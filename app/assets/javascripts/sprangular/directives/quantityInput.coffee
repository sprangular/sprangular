'use strict'

Sprangular.directive 'quantityInput', ->
  restrict: 'E'
  templateUrl: 'directives/quantity_input.html'
  scope:
    variant: '='
    updateCart: '='
    quantity: '='

  controller: ($scope, Cart, Angularytics) ->
    $scope.$watch 'quantity', (newValue, oldValue)->
      if oldValue != newValue
        Cart.updateItemQuantity($scope.variant.id, $scope.quantity) if $scope.updateCart

        if oldValue > newValue
          Angularytics.trackEvent("Cart", "Quantity decrease", oldValue - newValue)
        else
          Angularytics.trackEvent("Cart", "Quantity increase", newValue - oldValue)

    $scope.update = (delta) ->
      $scope.quantity += delta unless ($scope.quantity + delta) == 0
