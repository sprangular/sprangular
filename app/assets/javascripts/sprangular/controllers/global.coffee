Sprangular.controller "GlobalCtrl", ($scope, $location, Status, Env, Flash) ->

  $scope.flash = Flash
  $scope.status = Status
  $scope.env = Env
  $scope.location = $location
  $scope.status.meta.active.imageUrl = ''
  $scope.status.meta.description = ''
  $scope.status.meta.keywords = ''

  $scope.$watch 'status.pageTitle', (pageTitle) ->
    $scope.title = if pageTitle
      "#{pageTitle} - #{Env.config.site_name}"
    else
      Env.config.site_name