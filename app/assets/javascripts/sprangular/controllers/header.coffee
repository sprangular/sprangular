Sprangular.controller "HeaderCtrl", ($scope, $state, $stateParams, Cart, Account, Catalog, Status) ->

  $scope.cart = Cart
  $scope.catalog = Catalog
  $scope.account = Account

  $scope.logoUrl = "Sprangular"

  $scope.toggleCart = ->
    Status.bodyState = if Status.bodyState is "is-drw--open is-cart--open" then "" else "is-drw--open is-cart--open"

  $scope.goToMyAccount = ->
    $state.go 'account'

  $scope.logout = ->
    Account.logout()
      .then (content) ->
        if $state.includes('checkout.*') or $state.includes('account')
          $state.go 'home'

  $scope.login = ->
    $state.go 'gateKeeper',
      nextState: $state.current.name
      productId: $stateParams.id
    ,
      location: false
