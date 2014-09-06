Sprangular.controller 'AccountCtrl', ($scope, $location, $routeParams, Status, Account) ->

  formData = { email: '', password: '', password_confirmation: '', errors: {} }

  $scope.account = Account
  $scope.editing = false
  $scope.formData = formData

  Account.init().then (account) ->
    $location.path('/') unless account.isLogged

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
        $location.path('/') if !Account.isLogged
      , (errors) ->
        console.log errors
        formData.errors = errors
