Sprangular.controller 'HomeCtrl', ($scope, Status, products, Cart) ->

  $scope.products = products

  $scope.addToCart = (variant, qty) ->
    Cart.addVariant variant, qty
