'use strict'

Sprangular.directive 'quantityInput', ->
  restrict: 'E'
  templateUrl: 'directives/quantity_input.html'
  scope:
    quantity: '='
  controller: ($scope) ->

    $scope.updateQuantity = (delta) ->
      $scope.quantity += delta unless ($scope.quantity + delta) == 0

