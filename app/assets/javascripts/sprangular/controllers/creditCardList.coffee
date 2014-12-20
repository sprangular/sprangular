Sprangular.controller 'CreditCardListCtrl', ($scope, Account) ->

  $scope.creditCards = Account.user.creditCards
