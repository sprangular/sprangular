Sprangular.directive 'addressForm', ->
  restrict: 'E'
  templateUrl: 'addresses/form.html'
  scope:
    address: '='
  controller: ($scope) ->
