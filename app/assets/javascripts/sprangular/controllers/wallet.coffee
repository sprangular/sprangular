Sprangular.controller 'WalletCtrl', ($scope, Account) ->

  $scope.wallet = Account.wallet

  $scope.delete = (card) ->
    $scope.wallet.delete(card)
      .then (wallet) ->
        console.log 'deleted'
      , (error) ->
        console.log error

