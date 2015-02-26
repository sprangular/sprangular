Sprangular.controller 'HomeCtrl', ($scope, Status, Catalog, products, Cart) ->
  $translate('app.home').then (paragraph) ->
    Status.currentPageTitle = paragraph

  $scope.products = products
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

    Catalog.products(null, index)
      .then (newPage) ->
        $scope.currentPage = index
        $scope.pageList = [1..products.totalPages]
        $scope.fetching = false
        $scope.products = newPage
        $scope.loadingComplete = newPage.isLastPage

  $scope.selectVariant = (variant) ->
    $scope.selectedVariants[variant.product.id] = variant

  $scope.isSelected = (variant) ->
    $scope.selectedVariants[variant.product.id] == variant
