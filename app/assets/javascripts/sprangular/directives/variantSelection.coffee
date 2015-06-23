'use strict'

Sprangular.directive 'variantSelection', ->
  restrict: 'E'
  templateUrl: 'directives/variant_selection.html'
  scope:
    product: '='
    variant: '='
    change: '&'
  controller: ($scope) ->
    $scope.values = {}
    $scope.isVariantSet = false
    $scope.isDropdownOpen = false

    $scope.$watch 'variant', (newVariant, oldVariant)->
      if newVariant != oldVariant
        $scope.change({oldVariant: oldVariant, newVariant: newVariant})
      if newVariant != oldVariant && $scope.variant
        $scope.toggleDropdown()

    $scope.isValueSelected = (value) ->
      $scope.values[value.option_type_id]?.id == value.id

    $scope.isValueAvailable = (value) ->
      $scope.product.availableValues(_.values($scope.values))

    $scope.selectValue = (value) ->
      $scope.values[value.option_type_id] = value
      $scope.variant = $scope.product.variantForValues(_.values($scope.values))

      if $scope.variant then $scope.isVariantSet = true

    $scope.toggleDropdown = ->
      $scope.isDropdownOpen = !$scope.isDropdownOpen

  link: (scope, element, attrs) ->
    scope.values = {}

    if scope.variant
      for value in scope.variant.option_values
        scope.values[value.option_type_id] = value