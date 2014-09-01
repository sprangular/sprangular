Sprangular.controller 'HomeCtrl', ($scope, Status, products, Cart) ->

  $scope.products = products

  $scope.addToCart = (variant, qty) ->
    Cart.addVariant(variant, qty)
      .success -> $scope.$emit('cart.add', {variant: variant, qty: qty})
