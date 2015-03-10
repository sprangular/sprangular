Sprangular.controller 'OrderListCtrl', ($scope, Account, Env) ->

  $scope.account = Account
  $scope.currencySymbol = Env.config.currency.symbol

  $scope.showOrderDetails = (order) ->
    alert 'TBD.  Will show the order confirmation page'
