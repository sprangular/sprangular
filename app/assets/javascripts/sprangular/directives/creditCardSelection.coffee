Sprangular.directive 'creditCardSelection', ->
  restrict: 'E'
  templateUrl: 'credit_cards/selection.html'
  scope:
    creditCard: '='
    creditCards: '='
    disabled: '=disabledFields'
    submitted: '='
    existingCreditCard: '='
  controller: ($scope) ->
    $scope.$watch 'creditCards', (creditCards) ->
      return unless creditCards

      if creditCards.length > 0
        found = _.find creditCards, (existing) ->
          existing.same($scope.creditCard)

        $scope.toggleExistingCreditCard() if found

    $scope.$watch 'creditCard.id', (creditCardId) ->
      return unless creditCardId
      $scope.lastCreditCardId = creditCardId

    $scope.toggleExistingCreditCard = ->
      $scope.existingCreditCard = !$scope.existingCreditCard

      if $scope.existingCreditCard
        if $scope.creditCardId
          $scope.creditCard = _.find $scope.creditCards, (creditCard) -> creditCard.id == $scope.lastCreditCardId

        $scope.creditCard = $scope.creditCards[0] unless $scope.creditCard
      else
        $scope.creditCard = new Sprangular.CreditCard()

  link: (element, attrs) ->
    attrs.disabled = false unless attrs.disabled?

  compile: (element, attrs) ->
    attrs.existingCreditCard = 'false' if attrs.existingCreditCard is undefined
    attrs.disabled = 'false' if attrs.disabled is undefined
