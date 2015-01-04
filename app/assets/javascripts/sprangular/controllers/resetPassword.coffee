Sprangular.controller 'ResetPasswordCtrl', ($scope, $location, $routeParams, Account, Status, Flash) ->
  Status.pageTitle = 'Reset password'
  request = { password: '', password_confirmation: '', reset_password_token: $routeParams.token, errors: {} }

  $scope.request = request

  $scope.submit = ->
    request.errors = {}

    Account.resetPassword(request)
      .then (content) ->
        Flash.success 'Your password was saved. By the way, we signed you in at the same time.'
        $location.path('/')

      , (errors) ->
        request.errors = errors

  $scope.cancel = ->
    $location.path '/'
