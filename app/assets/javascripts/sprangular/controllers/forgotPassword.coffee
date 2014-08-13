Sprangular.controller 'ForgotPasswordCtrl', ($scope, $state, Account, Status) ->
  request = { email: '', errors: {} }

  # Open Drawer !!! Refactor
  if $state.is "forgotPassword"
    Status.bodyState = "is-drw--open is-signin--open"
  $scope.toggleSignin = ->
    Status.bodyState = if Status.bodyState is "is-drw--open is-signin--open" then "" else "is-drw--open is-signin--open"

  $scope.request = request
  $scope.requestSent = false

  $scope.submit = ->
    request.errors = {}
    $scope.requestSent = false
    Account.forgotPassword(request)
      .then (content) ->
        request.email = ''
        $scope.requestSent = true
      , (errors) ->
        console.log errors
        request.errors = errors

  $scope.cancel = ->
    $scope.toggleSignin()
    $state.go 'home'

