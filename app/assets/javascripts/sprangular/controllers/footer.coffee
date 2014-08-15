Sprangular.controller "FooterCtrl", ($scope, $location, Account, Catalog, Status) ->

  $scope.catalog = Catalog
  $scope.account = Account

  $scope.goToMyAccount = ->
    $location.path '/account'
