Sprangular.controller 'OrderDetailCtrl', ($scope, order, Env) ->
  $scope.order = order
  $scope.currencySymbol = Env.currency.symbol
