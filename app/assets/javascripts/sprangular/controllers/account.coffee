Sprangular.controller 'AccountCtrl', ($scope, $location, $routeParams, Status, Account) ->

  user = { email: '', password: '', password_confirmation: '', errors: {} }

  $scope.account = Account
  $scope.editing = false
  $scope.user = user

  $scope.edit = ->
    user.email = Account.email
    $scope.editing = true

  $scope.stopEdit = ->
    $scope.editing = false

  $scope.save = ->
    user.errors = {}

    Account.save(user)
      .then (content) ->
        $scope.editing = false
        $location.path('/') if !Account.isLogged
      , (errors) ->
        console.log errors
        user.errors = errors
