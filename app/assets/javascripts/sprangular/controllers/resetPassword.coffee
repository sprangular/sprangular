Sprangular.controller 'ResetPasswordCtrl', ($scope, $location, $routeParams, Account, Status, Flash) ->
  $translate('account.reset_password').then (paragraph) ->
    Status.pageTitle = paragraph

  request = { password: '', password_confirmation: '', reset_password_token: $routeParams.token, errors: {} }

  $scope.request = request

  $scope.submit = ->
    request.errors = {}

    Account.resetPassword(request)
      .then (content) ->
        $translate('app.password_saved').then (paragraph) ->
          Flash.success paragraph

        $location.path('/')

      , (errors) ->
        request.errors = errors

  $scope.cancel = ->
    $location.path '/'
