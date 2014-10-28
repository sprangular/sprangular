Sprangular.controller 'SubscriptionCtrl', ($scope, $timeout, Newsletter) ->
  $scope.subscribing = false
  $scope.done = false
  $scope.email = ''

  $scope.subscribe = ->
    $scope.subscribing = true
    $scope.error = false
    $scope.done = false

    success = ->
      $scope.email = ''
      $scope.subscribing = false
      $scope.done = true

      $timeout((-> $scope.done = false), 3000)

    error = ->
      $scope.error = true
      $scope.subscribing = false

    Newsletter.subscribe($scope.email)
      .then(success, error)
