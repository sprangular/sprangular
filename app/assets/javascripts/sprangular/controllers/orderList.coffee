Sprangular.controller 'OrderListCtrl', ($scope, Account, Env) ->
  $scope.account = Account
  $scope.currencySymbol = Env.currency.symbol
