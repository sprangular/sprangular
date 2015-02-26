Sprangular.controller 'SigninCtrl', ($scope, $location, Account, Flash, Status) ->
  $translate('nav.sign_in').then (paragraph) ->
    Status.pageTitle = paragraph
  $scope.signingUp = false
  $scope.askForEmail = false

  $scope.user = {}

  $scope.$watch ->
    Account.email
  , (newVal) ->
    $scope.user.email = newVal if newVal

  $scope.login = ->
    $scope.signingIn = true

    Account.login($scope.user)
      .success (content) ->
        $scope.signingIn = false
        $scope.$emit('account.login', Account)

        $location.path(Status.requestedPath || "/")
        Status.requestedPath = null

      .error ->
        $scope.signingIn = false

  $scope.cancelEmailAsking = ->
    $scope.askForEmail = false
