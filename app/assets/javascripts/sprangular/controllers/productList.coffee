Sprangular.controller 'ProductListCtrl', ($scope, $routeParams, Status, taxon, products, Catalog, Cart) ->
  if taxon
    Status.pageTitle = taxon.pretty_name
    $scope.taxon = taxon
  else
    Status.setPageTitle('nav.products')

  $scope.products = products
  $scope.taxonomies = Catalog.taxonomies()
  $scope.currentPage = 1
  $scope.pageList = [1..products.totalPages]
  $scope.loadingComplete = false
  $scope.fetching = false
  $scope.selectedVariants = {}

  $scope.loadNextPage = ->
    $scope.loadPage($scope.currentPage + 1)

  $scope.loadPreviousPage = ->
    $scope.loadPage($scope.currentPage - 1) unless $scope.currentPage == 0

  $scope.loadPage = (index) ->
    $scope.fetching = true

    load = if taxon
      Catalog.productsByTaxon(taxon.permalink, index)
    else
      Catalog.products($routeParams.search, index)

    load.then (newPage) ->
      $scope.currentPage = index
      $scope.pageList = [1..products.totalPages]
      $scope.fetching = false
      $scope.products = newPage
      $scope.loadingComplete = newPage.isLastPage

  $scope.selectVariant = (variant) ->
    $scope.selectedVariants[variant.product.id] = variant

  $scope.isSelected = (variant) ->
    $scope.selectedVariants[variant.product.id] == variant
