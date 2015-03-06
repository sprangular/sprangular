'use strict'

Sprangular.directive 'flexiSelection', ($log)->
  restrict: 'E'
  templateUrl: 'directives/flexi_selection.html'
  scope:
    product: '='
    class: '='
    change: '&'
  controller: ($scope) ->

    $log.debug $scope
    # $scope.values = {}

    # $scope.$watch 'variant', (newVariant, oldVariant)->
    #   $scope.change({oldVariant: oldVariant, newVariant: newVariant}) if newVariant != oldVariant

    # $scope.isValueSelected = (value) ->
    #   $scope.values[value.option_type_id]?.id == value.id

    # $scope.isValueAvailable = (value) ->
    #   $scope.product.availableValues(_.values($scope.values))

    # $scope.selectValue = (value) ->
    #   $scope.values[value.option_type_id] = value
    #   $scope.variant = $scope.product.variantForValues(_.values($scope.values))

  link: (scope, element, attrs) ->
    # scope.values = {}

    # if scope.variant
    #   for value in scope.variant.option_values
    #     scope.values[value.option_type_id] = value
