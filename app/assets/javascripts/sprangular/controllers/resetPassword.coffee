Sprangular.controller 'ResetPasswordCtrl', ($scope, $location, $routeParams, Account, Status) ->
  request = { password: '', password_confirmation: '', reset_password_token: $routeParams.token, errors: {} }

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
    $location.path '/'
