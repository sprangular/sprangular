Sprangular.controller 'AddressListCtrl', ($scope, Account) ->

  $scope.addresses = Account.user.addresses
