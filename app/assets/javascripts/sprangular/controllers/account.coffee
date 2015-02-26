Sprangular.controller 'AccountCtrl', (
  $scope,
  $location,
  $routeParams,
  Status,
  Account,
  user,
  $translate
) ->
  $translate('nav.my_account').then (paragraph) ->
    Status.pageTitle = paragraph

  user.password = ''
  user.password_confirmation = ''

  $scope.editing = false
  $scope.user = user

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
