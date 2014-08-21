Sprangular.controller 'ProductListCtrl', ($scope, Status, taxon, products, Cart) ->
  $scope.status = Status

  if taxon
    Status.pageTitle = taxon.pretty_name
  else
    Status.pageTitle = 'Products'

  $scope.products = products

  $scope.addToCart = (variant, qty) ->
    Cart.addVariant variant, qty
