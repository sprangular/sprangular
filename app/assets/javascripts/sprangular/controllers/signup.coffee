Sprangular.controller 'SignupCtrl', ($scope, Account, Status) ->
  signup = { email: '', password: '', password_confirmation: '', errors: {} }

  $scope.signup = signup
  $scope.showFacebookConnect = false

  $scope.submit = ->
    signup.errors = {}
    $scope.showFacebookConnect = false
    Account.signup(signup)
      .then (content) ->
        signup.email = ''
        signup.password = ''
        signup.password_confirmation = ''
        $scope.accountLoaded content

        Flash.success("Successfully signed up!")
        $location.path(Status.requestedPath || "/")
        Status.requestedPath = null

      , (errors) ->
        console.log errors
        signup.errors = errors
        if /Facebook/.test errors.email
          $scope.showFacebookConnect = true

