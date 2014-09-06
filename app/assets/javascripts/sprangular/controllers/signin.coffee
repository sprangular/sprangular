Sprangular.controller 'SigninCtrl', ($scope, $location, Account, Facebook, Flash, Status) ->

  $scope.signingUp = false
  $scope.askForEmail = false

  $scope.user = {}
  $scope.signinError = null

  $scope.facebookEmail = null

  $scope.account = Account

  # Get properties
  Account.init().then (content) ->
    $scope.loaded()

  $scope.$watch ->
    Account.email
  , (newVal) ->
    $scope.user.email = newVal if newVal

  $scope.login = ->
    $scope.signinError = null
    Account.login($scope.user)
      .then (content) ->
        $scope.loaded()
        $location.path(Status.requestedPath || '/')
      , (error) ->
        $scope.signinError = error

  $scope.toggleSigninUp = ->
    $scope.signingUp = !$scope.signingUp

  $scope.connectWithFacebook = ->
    Facebook.login($scope.facebookEmail)
      .then (content) ->
        Account.reload()
          .then (content) ->
            $scope.loaded()
            $scope.askForEmail = false
      , (error) ->
        if error.status == 404
          $scope.askForEmail = true

  $scope.cancelEmailAsking = ->
    $scope.askForEmail = false
    $scope.facebookEmail = null

  $scope.loaded = ->
    $scope.signingUp = false

    if Account.isLogged
      $scope.$emit('account.login', Account)

      Flash.success("Successfully signed in!")
      $location.path(Status.requestedPath || "/")
      Status.requestedPath = null
