Sprangular.controller 'SignupCtrl', ($scope, $location, Account, Status, Flash, $translate) ->
  Status.pageTitle = 'Sign up'
  $scope.user = { email: '', password: '', password_confirmation: '', errors: {} }
  $scope.signingUp = false

  $scope.submit = ->
    $scope.user.errors = {}
    $scope.signingUp = true

    Account.signup($scope.user)
      .success (content) ->
        $scope.signingUp = false
        $translate('app.signed_up_msg').then (paragraph) ->
          Flash.success paragraph
        $location.path(Status.requestedPath || "/")
        Status.requestedPath = null

      .error (data) ->
        $scope.signingUp = false
        $scope.user.errors = data.errors
