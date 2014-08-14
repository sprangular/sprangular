Sprangular.controller "HeaderCtrl", ($scope, $location, $routeParams, Cart, Account, Catalog, Env, Status) ->

  $scope.cart = Cart
  $scope.catalog = Catalog
  $scope.account = Account
  $scope.env = Env

  $scope.toggleCart = ->
    Status.bodyState = if Status.bodyState is "is-drw--open is-cart--open" then "" else "is-drw--open is-cart--open"

  $scope.goToMyAccount = ->
    $location.path '/account'

  $scope.logout = ->
    Account.logout()
      .then (content) ->
        $location.path '/'

  $scope.login = ->
    $location.path '/sign-in'
