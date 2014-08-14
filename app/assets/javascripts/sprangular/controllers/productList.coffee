Sprangular.controller 'ProductListCtrl', ($scope, Status, products, Cart) ->

  Status.pageTitle = 'Product List page'

  $scope.products = products

  $scope.addToCart = (variant, qty) ->
    Cart.addVariant variant, qty
