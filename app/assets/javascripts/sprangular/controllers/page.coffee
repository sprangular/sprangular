Sprangular.controller 'PageShowCtrl', ($scope, $http, $routeParams, Status) ->
  $http.get("/api/pages/#{$routeParams.id}.json").success((data) ->
    $scope.page = data
    Status.pageTitle        = $scope.page.title
    Status.meta.description = $scope.page.meta_description
  )
