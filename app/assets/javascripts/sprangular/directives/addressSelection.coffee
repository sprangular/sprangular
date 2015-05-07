Sprangular.directive 'addressSelection', ->
  restrict: 'E'
  templateUrl: 'addresses/selection.html'
  scope:
    address: '='
    addresses: '='
    countries: '='
    disabled: '=disabledFields'
    submitted: '='
    existingAddress: '='
  controller: ($scope) ->
    $scope.$watch 'addresses', (addresses) ->
      return unless addresses && addresses.length > 0

      found = _.find addresses, (existing) ->
        existing.same($scope.address)

      $scope.toggleExistingAddress() if found

    $scope.$watch 'address.id', (addressId) ->
      return unless addressId
      $scope.lastAddressId = addressId

    $scope.toggleExistingAddress = ->
      $scope.existingAddress = !$scope.existingAddress

      if $scope.existingAddress
        if $scope.lastAddressId
          $scope.address = _.find $scope.addresses, (addr) -> addr.id == $scope.lastAddressId

        $scope.address = $scope.addresses[0] unless $scope.address
      else
        $scope.address = new Sprangular.Address()

  compile: (element, attrs) ->
    attrs.existingAddress = 'false' if attrs.existingAddress is undefined
    attrs.disabled = 'false' if attrs.disabled is undefined
