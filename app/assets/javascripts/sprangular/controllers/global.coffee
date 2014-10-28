Sprangular.controller "GlobalCtrl", ($scope, Status, Env, Flash) ->

  $scope.flash = Flash
  $scope.status = Status
  $scope.env = Env

  $scope.title = ->
    if status.pageTitle
      "#{Status.pageTitle} - #{Env.config.site_name}"
    else
      Env.config.site_name
