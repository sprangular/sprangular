Sprangular.controller 'SigninCtrl', (
  $scope,
  $location,
  Account,
  Flash,
  Status,
  $translate
) ->
  Status.setPageTitle('nav.login')

  $scope.signingUp = false
  $scope.askForEmail = false

  $scope.user = {}

  $scope.$watch ->
    Account.email
  , (newVal) ->
    $scope.user.email = newVal if newVal

  $scope.guestLogin = ->
    $scope.signingIn = true

    Account.guestLogin($scope.cart)
      .success (content) ->
        $scope.signingIn = false
        $scope.$emit('account.login', Account)
        $location.path(Status.requestedPath || "/")
        Status.requestedPath = null
      .error ->
        $scope.signingIn = false

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
