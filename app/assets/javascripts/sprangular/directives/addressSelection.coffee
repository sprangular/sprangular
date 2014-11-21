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
        found = _.find addresses, (existing) ->
          existing.same($scope.address)

        $scope.existingAddress = true if found

    $scope.toggleExistingAddress = ->
      $scope.existingAddress = !$scope.existingAddress

      if $scope.existingAddress
        $scope.address = $scope.addresses[0]
