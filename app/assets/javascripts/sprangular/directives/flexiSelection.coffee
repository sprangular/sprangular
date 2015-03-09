'use strict'

Sprangular.directive 'flexiSelection', ($log)->
  restrict: 'E'
  templateUrl: 'directives/flexi_selection.html'
  scope:
    product: '='
    class: '='
    change: '&'
    selected: "="
  controller: ($scope) ->

    $log.debug $scope

    # $scope.$watch 'ad_hoc', (n, o)->
    #   $log.debug "$watch 'ad_hoc'", n, o

    # $scope.$watch 'selected', (n, o)->
    #   $log.debug "$watch 'selected'", n, o
    #   # $scope.change({oldVariant: oldVariant, newVariant: newVariant}) if newVariant != oldVariant

    # # $scope.isValueSelected = (value) ->
    # #   $scope.values[value.option_type_id]?.id == value.id

    # # $scope.isValueAvailable = (value) ->
    # #   $scope.product.availableValues(_.values($scope.values))

    # # $scope.selectValue = (value) ->
    # #   $scope.values[value.option_type_id] = value
    # #   $scope.variant = $scope.product.variantForValues(_.values($scope.values))

  link: (scope, element, attrs) ->
    scope.ad_hoc = if (scope.product.ad_hoc_option_types?) then scope.product.ad_hoc_option_types else null
    scope.custom = if (scope.product.product_customization_types?) then scope.product.product_customization_types else null
