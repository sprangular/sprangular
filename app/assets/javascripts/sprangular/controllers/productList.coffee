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
  $scope.selectedVariants = {}

  $scope.loadNextPage = ->
    $scope.fetching = true

    load = if taxon
      Catalog.productsByTaxon(taxon.permalink, $scope.page+1)
    else
      Catalog.products($routeParams.search, $scope.page+1)

    load.then (newPage) ->
      $scope.page++
      $scope.fetching = false
      $scope.products = $scope.products.concat(newPage)
      $scope.loadingComplete = newPage.isLastPage

  $scope.selectVariant = (variant) ->
    $scope.selectedVariants[variant.product.id] = variant

  $scope.isSelected = (variant) ->
    $scope.selectedVariants[variant.product.id] == variant
