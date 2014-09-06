Sprangular.controller 'SigninCtrl', ($scope, $location, Account, Facebook, Flash, Status) ->

  $scope.signingUp = false
  $scope.askForEmail = false

  $scope.user = {}

  $scope.facebookEmail = null

  # Get properties
  Account.init()

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

  $scope.connectWithFacebook = ->
    Facebook.login($scope.facebookEmail)
      .then (content) ->
        Account.reload()
          .then (content) ->
            $scope.askForEmail = false
      , (error) ->
        if error.status == 404
          $scope.askForEmail = true

  $scope.cancelEmailAsking = ->
    $scope.askForEmail = false
    $scope.facebookEmail = null
