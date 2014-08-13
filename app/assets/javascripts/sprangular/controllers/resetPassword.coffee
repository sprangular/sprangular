Sprangular.controller 'ResetPasswordCtrl', ($scope, $state, Account, Status) ->
  request = { password: '', password_confirmation: '', reset_password_token: $state.params.token, errors: {} }

  # Open Drawer !!! Refactor
  if $state.is "resetPassword"
    Status.bodyState = "is-drw--open is-signin--open"
  $scope.toggleSignin = ->
    Status.bodyState = if Status.bodyState is "is-drw--open is-signin--open" then "" else "is-drw--open is-signin--open"

  $scope.request = request
  $scope.requestSent = false

  $scope.submit = ->
    request.errors = {}
    $scope.requestSent = false
    Account.resetPassword(request)
      .then (content) ->
        request.password = ''
        request.password_confirmation = ''
        $scope.requestSent = true
      , (errors) ->
        console.log errors
        request.errors = errors

  $scope.cancel = ->
    $scope.toggleSignin()
    $state.go 'home'

