Sprangular.controller 'AccountCtrl', ($scope, $location, $routeParams, Status, Account) ->
  Status.pageTitle = 'My Account'

  user = Account.user

  $scope.editing = false
  $scope.user = user

  refreshAccount = ->
    Account.init().then ->
      user = Account.user
      user.password = ''
      user.password_confirmation = ''

  $scope.edit = ->
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
        user.errors = errors

  refreshAccount()
