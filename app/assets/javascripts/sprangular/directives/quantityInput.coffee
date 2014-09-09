'use strict'

Sprangular.directive 'quantityInput', ->
  restrict: 'E'
  templateUrl: 'directives/quantity_input.html'
  scope:
    quantity: '='
    change: '&'

  controller: ($scope) ->
    $scope.$watch 'quantity', (oldValue, newValue)->
      $scope.change() if oldValue != newValue

    $scope.update = (delta) ->
      $scope.quantity += delta unless ($scope.quantity + delta) == 0
