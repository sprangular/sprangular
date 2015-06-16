Sprangular.controller 'ProductListCtrl', ($scope, $routeParams, Status, taxon, products, Catalog, Cart, $location) ->
  if taxon
    Status.pageTitle = taxon.pretty_name
    $scope.taxon = taxon
  else
    Status.setPageTitle('nav.products')

  $scope.products = products
  $scope.taxonomies = Catalog.taxonomies()
  $scope.page = 1
  $scope.loadingComplete = false
  $scope.fetching = false
  $scope.selectedVariants = {}
  $scope.filters = {}

  $scope.$watch 'filters', (newFilters, oldFilters)->
    return unless oldFilters
    $scope.page = 1

  $scope.$watch (-> $location.$$url), (url) ->
    query = url.split("?")[1]
    filters = Sprangular.queryString.parse(query)

    if filters.taxons?
      for k, v of filters.taxons
        filters.taxons[k] = v.split(",")

    if filters.optionTypes?
      for k, v of filters.optionTypes
        filters.optionTypes[k] = v.split(",")

    $scope.filters = filters

  $scope.loadNextPage = ->
    return if $scope.loadingComplete || $scope.fetching

    params = angular.copy($scope.filters)
    params.ignoreLoadingIndicator = true

    $scope.fetching = true

    load = if taxon
      Catalog.productsByTaxon(taxon.id, $scope.page+1, params)
    else
      Catalog.products($scope.filters.keywords, $scope.page+1, params)

    load.then (newPage) ->
      $scope.page++
      $scope.fetching = false
      $scope.products = $scope.products.concat(newPage)
      $scope.loadingComplete = newPage.isLastPage

  $scope.selectVariant = (variant) ->
    $scope.selectedVariants[variant.product.id] = variant

  $scope.isSelected = (variant) ->
    $scope.selectedVariants[variant.product.id] == variant
