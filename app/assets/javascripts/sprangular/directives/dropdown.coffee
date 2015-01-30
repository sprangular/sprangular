'use strict'

Sprangular.directive 'dropdown', ->
  restrict: 'E'
  templateUrl: 'directives/dropdown.html'
  scope:
    label: '='
    options: '='
    class: '='
    change: '='

  controller: ($scope) ->
    $scope.selected = "Please select an option"
    $scope.expanded = false
    $scope.value = null

    # function that expands dropdown
    $scope.expand = () ->
      $scope.expanded = true

    # function that selects a value, called by ng-click
    $scope.select = (value) ->
      $scope.value = value
      $scope.selected = value.presentation # save the value on the scope, so that the ui shows selected value, and we have it for form submissions
      $scope.expanded = false # hide the dropdown list
