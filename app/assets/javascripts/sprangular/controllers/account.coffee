Sprangular.controller 'AccountCtrl', ($scope, $state, $stateParams, Status, Account) ->

  formData = { email: '', password: '', password_confirmation: '', errors: {} }

  $scope.account = Account
  $scope.editing = false
  $scope.formData = formData

  Account.fetch().then (account) ->
    if !account.isLogged
      $state.go 'gateKeeper',
        nextState: 'account'
      ,
        location: false

  $scope.edit = ->
    formData.email = Account.email
    $scope.editing = true

  $scope.stopEdit = ->
    $scope.editing = false

  $scope.save = ->
    formData.errors = {}
    Account.save(formData)
      .then (content) ->
        $scope.editing = false
        if !Account.isLogged
          $state.go 'gateKeeper',
            nextState: 'account'
          ,
            location: false
      , (errors) ->
        console.log errors
        formData.errors = errors
