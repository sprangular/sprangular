Sprangular.controller "GlobalCtrl", ($scope, Status, Env, Flash) ->

  $scope.flash = Flash
  $scope.status = Status
  $scope.env = Env

  $scope.$watch 'status.pageTitle', (pageTitle) ->
    $scope.title = if pageTitle
      "#{pageTitle} - #{Env.config.site_name}"
    else
      Env.config.site_name
