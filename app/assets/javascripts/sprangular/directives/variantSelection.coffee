'use strict'

Sprangular.directive 'variantSelection', ->
  restrict: 'E'
  templateUrl: 'directives/variant_selection.html'
  scope:
    product: '='
    variant: '='
    class: '='
    change: '&'
  controller: ($scope) ->
    $scope.$watch 'variant', (newVariant, oldVariant)->
      $scope.change({oldVariant: oldVariant, newVariant: newVariant}) if newVariant != oldVariant

    $scope.$watchCollection 'values', (newValues) ->
      $scope.variant = $scope.product.variantForValues(_.values(newValues))

    $scope.isValueSelected = (value) ->
      $scope.values[value.option_type_id]?.id == value.id

    $scope.isValueAvailable = (value) ->
      $scope.product.availableValues(_.values($scope.values))

  link: (scope, element, attrs) ->
    scope.values = {}

    if scope.variant
      for value in scope.variant.option_values
        scope.values[value.option_type_id] = value

    else if scope.product
      for type in scope.product.option_values
        scope.values[value.option_type_id] = value
