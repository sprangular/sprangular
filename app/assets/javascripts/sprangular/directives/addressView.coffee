'use strict'

Sprangular.directive 'addressView', ->
  restrict: 'E'
  templateUrl: 'addresses/address.html'
  scope:
    address: '='
