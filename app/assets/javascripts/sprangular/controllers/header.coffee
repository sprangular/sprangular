Sprangular.controller "HeaderCtrl", ($scope, $location, $routeParams, Cart, Account, Catalog, Env, Status) ->

  $scope.cart = Cart
  $scope.catalog = Catalog
  Catalog.taxonomies().then (taxonomies) ->
    $scope.taxonomies = taxonomies
  $scope.account = Account
  $scope.env = Env

  $scope.goToMyAccount = ->
    $location.path '/account'

  $scope.logout = ->
    Account.logout()
      .then (content) ->
        $location.path '/'

  $scope.login = ->
    $location.path '/sign-in'
