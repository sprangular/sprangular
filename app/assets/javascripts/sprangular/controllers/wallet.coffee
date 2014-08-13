Sprangular.controller 'WalletCtrl', ($scope, Account) ->

  $scope.wallet = null

  Account.fetch().then (account) ->
    $scope.wallet = account.wallet

  $scope.delete = (card) ->
    $scope.wallet.delete(card)
      .then (wallet) ->
        console.log 'deleted'
      , (error) ->
        console.log error

