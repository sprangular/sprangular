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
    $scope.isVariantOpen = false
    $scope.isWrapperOpen = false
    $scope.variantSet = false
    $scope.variantPresentations = false

    $scope.$watch 'variant', (newVariant, oldVariant)->
      if newVariant != oldVariant
        $scope.change({oldVariant: oldVariant, newVariant: newVariant})
        $scope.variantSet = true
        $scope.isWrapperOpen = false

        if(newVariant.option_values.length > 0)
          $scope.variantPresentations = []

          for value in newVariant.option_values
            $scope.variantPresentations.push(value.presentation)


    $scope.$watchCollection 'values', (newValues) ->
      $scope.variant = $scope.product.variantForValues(_.values(newValues))

    $scope.isValueSelected = (value) ->
      $scope.values[value.option_type_id]?.id == value.id

    $scope.isValueAvailable = (value) ->
      $scope.product.availableValues(_.values($scope.values))

    $scope.openWrapper = ->
      $scope.isWrapperOpen = true

  link: (scope, element, attrs) ->
    scope.values = {}

    if scope.variant
      for value in scope.variant.option_values
        scope.values[value.option_type_id] = value

    else if scope.product
      for type in scope.product.option_values
        scope.values[value.option_type_id] = value
