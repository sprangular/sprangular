Sprangular.controller 'AddressCtrl', ($rootScope, $scope, Address) ->
  $scope.address = { state: null }
  $scope.states = Address.getStatesList()
