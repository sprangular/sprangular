Sprangular.controller 'HomeCtrl', ($scope, Status, Catalog, products, Cart) ->

  $scope.products = products
  $scope.page = 1
  $scope.loadingComplete = false
  $scope.fetching = false
  $scope.selectedVariants = {}

  $scope.loadNextPage = ->
    $scope.fetching = true

    Catalog.products(null, $scope.page+1)
      .then (newPage) ->
        $scope.page++
        $scope.fetching = false
        $scope.products = $scope.products.concat(newPage)
        $scope.loadingComplete = newPage.isLastPage

  $scope.selectVariant = (variant) ->
    $scope.selectedVariants[variant.product.id] = variant

  $scope.isSelected = (variant) ->
    $scope.selectedVariants[variant.product.id] == variant
