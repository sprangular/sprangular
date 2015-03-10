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
    $log.debug "Controller"

  link: (scope, element, attrs) ->
    scope.ad_hoc = if (scope.product.ad_hoc_option_types?) then scope.product.ad_hoc_option_types else null
    scope.custom = if (scope.product.product_customization_types?) then scope.product.product_customization_types else null
