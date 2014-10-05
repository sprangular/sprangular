'use strict'

Sprangular.directive 'creditCardView', ->
  restrict: 'E'
  templateUrl: 'credit_cards/credit_card.html'
  scope:
    card: '='
    allowDelete: '@'

  controller: ($scope, Account) ->
    $scope.delete: ->
      Account.wallet.delete(card)
