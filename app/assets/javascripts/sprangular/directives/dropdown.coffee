'use strict'

Sprangular.directive 'dropdown', ($parse) ->
  restrict: 'E'
  require: ['?ngModel']
  templateUrl: 'directives/dropdown.html'
  scope:
    description: '@'
    label: '@'
    options: '='
    class: '='
    emptyMessage: '@'

  link: (scope, element, attrs, ctrls) ->
    ngModelCtrl = ctrls[0]

    if !attrs.emptyMessage
      attrs.emptyMessage = '-- Choose --'

    scope.model = ngModelCtrl

  controller: ($scope) ->
    $scope.expanded = false

    $scope.expand = ->
      $scope.expanded = true

    $scope.displayValue = (val) ->
      return unless val

      if $scope.label
        eval "val.#{$scope.label}"
      else
        val

    $scope.select = (value) ->
      $scope.model.$setViewValue(value)
      $scope.expanded = false
