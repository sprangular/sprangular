Sprangular.controller 'ProductListCtrl', ($scope, Status, Catalog, Cart) ->

  Status.pageTitle = 'Product List page'
  Status.bodyClass = "p-list"

  $scope.catalog = Catalog

  $scope.addToCart = (variant, qty) ->
    Cart.addVariant variant, qty
