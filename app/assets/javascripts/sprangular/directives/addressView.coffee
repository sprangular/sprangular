'use strict'

Sprangular.directive 'addressView', ->
  restrict: 'E'
  templateUrl: 'addresses/address.html'
  scope:
    address: '='
    allowDelete: '='

  controller: ($scope, Account) ->
    $scope.delete = ->
      Account.deleteAddress($scope.address)
