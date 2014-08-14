Sprangular.controller 'ForgotPasswordCtrl', ($scope, $location, Account, Status) ->
  request = { email: '', errors: {} }

  $scope.request = request
  $scope.requestSent = false

  $scope.submit = ->
    request.errors = {}
    $scope.requestSent = false
    Account.forgotPassword(request)
      .then (content) ->
        request.email = ''
        $scope.requestSent = true
      , (errors) ->
        console.log errors
        request.errors = errors

  $scope.cancel = ->
    $location.path '/'
