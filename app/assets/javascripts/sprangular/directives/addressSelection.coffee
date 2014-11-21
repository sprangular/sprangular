Sprangular.directive 'addressSelection', ->
  restrict: 'E'
  templateUrl: 'addresses/selection.html'
  scope:
    address: '='
    addresses: '='
    countries: '='
  controller: ($scope) ->
    $scope.existingAddress = false

    $scope.$watch 'addresses', (addresses) ->
      return unless addresses

      if addresses.length > 0
        $scope.existingAddress = true

    $scope.$watch 'address', (address) ->
      found = _.find address, (existing) ->
        existing.same(address)
