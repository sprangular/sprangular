Sprangular.controller 'ProductListCtrl', ($scope, $routeParams, Status, taxon, products, Catalog, Cart) ->
  if taxon
    $scope.pageTitle = taxon.pretty_name
  else
    $scope.pageTitle = 'Products'

  Status.pageTitle = $scope.pageTitle

  $scope.products = products
  $scope.page = 1
  $scope.loadingComplete = false
  $scope.fetching = false

  $scope.loadNextPage = ->
    $scope.fetching = true

    Catalog.products($routeParams.search, $scope.page+1)
      .then (newPage) ->
        $scope.page++
        $scope.fetching = false
        $scope.products = $scope.products.concat(newPage)
        $scope.loadingComplete = newPage.isLastPage

  $scope.addToCart = (variant, qty) ->
    Cart.addVariant(variant, qty)
      .success -> $scope.$emit('cart.add', {variant: variant, qty: qty})
