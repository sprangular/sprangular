Sprangular.directive 'creditCardSelection', ->
  restrict: 'E'
  templateUrl: 'credit_cards/selection.html'
  scope:
    creditCard: '='
    creditCards: '='
    disabled: '=disabledFields'
    submitted: '='
  controller: ($scope) ->
    $scope.existingCreditCard = false

    $scope.$watch 'creditCards', (creditCards) ->
      return unless creditCards

      if creditCards.length > 0
        found = _.find creditCards, (existing) ->
          existing.same($scope.creditCard)

        $scope.toggleExistingCreditCard() if found

    $scope.toggleExistingCreditCard = ->
      $scope.existingCreditCard = !$scope.existingCreditCard

      if $scope.existingCreditCard
        $scope.creditCard = $scope.creditCards[0]
      else
        $scope.creditCard = new Sprangular.CreditCard

  link: (element, attrs) ->
    attrs.disabled = false unless attrs.disabled?
