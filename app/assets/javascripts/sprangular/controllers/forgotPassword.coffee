Sprangular.controller 'ForgotPasswordCtrl', ($scope, $location, Account, Flash, Status) ->
  Status.title = 'Forgot Password'

  request = { email: '', errors: {} }

  $scope.request = request

  $scope.submit = ->
    request.errors = {}

    success = ->
      $location.path '/'
      Flash.success("We've sent you an email with a link to reset your password.")

    error = (response) ->
      request.errors = response.data.errors

    Account.forgotPassword(request).then(success, error)

  $scope.cancel = ->
    $location.path '/'
