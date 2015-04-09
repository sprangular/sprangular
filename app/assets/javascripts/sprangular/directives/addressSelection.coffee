Sprangular.directive 'addressSelection', ->
  restrict: 'E'
  templateUrl: 'addresses/selection.html'
  scope:
    address: '='
    addresses: '='
    countries: '='
    disabled: '='
    submitted: '='
  controller: ($scope) ->
    $scope.existingAddress = false

    $scope.$watch 'addresses', (addresses) ->
      return unless addresses && addresses.length > 0

      found = _.find addresses, (existing) ->
        existing.same($scope.address)

      $scope.toggleExistingAddress() if found

    $scope.toggleExistingAddress = ->
      $scope.existingAddress = !$scope.existingAddress

      if $scope.existingAddress
        $scope.address = $scope.addresses[0]
      else
        $scope.address = new Sprangular.Address()

  link: (element, attrs) ->
    attrs.disabled = false unless attrs.disabled?
