Sprangular.controller 'ProductCtrl', ($scope, Status, product, Cart) ->
  $scope.product = product
  $scope.selected =
    product: product.variants[0]
    quantity: 1

  Status.pageTitle = $scope.product.name

  $scope.changeQuantity = (val) ->
    $scope.selected.quantity = val

  $scope.addToCart = (variant, qty) ->
    Cart.addVariant variant, qty
    $scope.$emit('cart.add', {variant: variant, qty: qty})

  $scope.updateQuantity = (delta) ->
    $scope.selected.quantity += delta unless ($scope.selected.quantity + delta) == 0

  $scope.selectVariant = (variant) ->
    $scope.selected.product = variant

  $scope.isSelected = (variant) ->
    variant.id is $scope.selected.product.id
