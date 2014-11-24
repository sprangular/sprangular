Sprangular.controller "HeaderCtrl", ($scope, $location, Cart, Account, Catalog, Env, Flash, Status, Angularytics) ->

  $scope.cart = Cart
  Catalog.taxonomies().then (taxonomies) ->
    $scope.taxonomies = taxonomies
  $scope.account = Account
  $scope.env = Env
  $scope.search = {text: $location.search()['search']}

  $scope.goToMyAccount = ->
    $location.path '/account'

  $scope.logout = ->
    Account.logout()
      .then (content) ->
        Angularytics.trackEvent("Account", "Logout")
        $scope.$emit('account.logout')
        Flash.success "Successfully logged out"
        $location.path '/'

  $scope.login = ->
    $location.path '/sign-in'

  $scope.doSearch = ->
    Angularytics.trackEvent("Product", "Search", $scope.search.text)

    product = _.find $scope.lastSearch, (product) ->
                product.name == $scope.search.text

    if product
      $location.path "/products/#{product.slug}"
    else
      $location.search('search', $scope.search.text)
      $location.path "/products"

  $scope.getProducts = (search) ->
    return [] unless search
    Catalog.products(search, 1, ignoreLoadingIndicator: true)
      .then (products) ->
        $scope.lastSearch = products
