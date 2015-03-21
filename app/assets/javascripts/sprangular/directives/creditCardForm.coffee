Sprangular.directive 'creditCardForm', ->
  restrict: 'E'
  templateUrl: 'credit_cards/form.html'
  scope:
    creditCard: '='
  controller: ($scope, $locale) ->
    $scope.months = _.map $locale.DATETIME_FORMATS.MONTH, (month, index) ->
      {"index": index + 1, "name": month}

    currentYear = (new Date).getFullYear()
    $scope.years = [currentYear .. currentYear+15]

    $scope.$watch 'creditCard.number', (number) ->
      return unless number
      $scope.creditCard.lastDigits = number.substr(-4)
      $scope.creditCard.determineType()
