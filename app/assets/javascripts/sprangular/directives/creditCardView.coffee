'use strict'

Sprangular.directive 'creditCardView', ->
  restrict: 'E'
  templateUrl: 'credit_cards/credit_card.html'
  scope:
    card: '='
    allowDelete: '@'

  controller: ($scope, Account) ->
    $scope.typeName = ->
      Sprangular.CreditCard.TYPE_NAMES[$scope.card.type]

    $scope.delete = ->
      Account.deleteCard($scope.card)
