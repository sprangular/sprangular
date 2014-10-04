Sprangular.directive 'creditCardForm', ->
  restrict: 'E'
  templateUrl: 'credit_cards/form.html'
  scope:
    creditCard: '='
  controller: ($scope) ->
    $scope.months = [
      {index: 1, name: 'January'},
      {index: 2, name: 'February'},
      {index: 3, name: 'March'},
      {index: 4, name: 'April'},
      {index: 5, name: 'May'},
      {index: 6, name: 'June'},
      {index: 7, name: 'July'},
      {index: 8, name: 'August'},
      {index: 9, name: 'September'},
      {index: 10, name: 'October'},
      {index: 11, name: 'November'},
      {index: 12, name: 'December'}
    ]

    currentYear = (new Date).getFullYear()
    $scope.years = [currentYear .. currentYear+15]

    $scope.$watch 'creditCard.number', ->
      $scope.creditCard.determineType()
