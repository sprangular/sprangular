Sprangular.controller 'ForgotPasswordCtrl', (
  $scope,
  $location,
  Account,
  Flash,
  Status,
  $translate
) ->
  $translate('app.forgot_password').then (paragraph) ->
    Status.title = paragraph

  request = { email: '', errors: {} }

  $scope.request = request

  $scope.submit = ->
    request.errors = {}

    success = ->
      $location.path '/'
      Flash.error('app.confirm_reset_password')

    error = (response) ->
      $translate('app.email_not_found').then (paragraph) ->
        request.errors['email'] = paragraph

    Account.forgotPassword(request).then(success, error)

  $scope.cancel = ->
    $location.path '/'
