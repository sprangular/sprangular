Sprangular.controller 'SignupCtrl', ($scope, Account) ->
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
      , (errors) ->
        console.log errors
        signup.errors = errors
        if /Facebook/.test errors.email
          $scope.showFacebookConnect = true

