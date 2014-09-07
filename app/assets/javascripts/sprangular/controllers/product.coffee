Sprangular.controller 'ProductCtrl', ($scope, Status, product, Cart) ->
  $scope.product = product
  $scope.adding = false
  $scope.selected =
    product: product.variants[0]
    image: product.variants[0].images[0]
    quantity: 1

  Status.pageTitle = $scope.product.name

  $scope.changeQuantity = (val) ->
    $scope.selected.quantity = val

  $scope.addToCart = (variant, qty) ->
    $scope.adding = true
    Cart.addVariant(variant, qty)
      .success ->
        $scope.adding = false
        $scope.$emit('cart.add', {variant: variant, qty: qty})

  $scope.updateQuantity = (delta) ->
    $scope.selected.quantity += delta unless ($scope.selected.quantity + delta) == 0

  $scope.selectVariant = (variant) ->
    $scope.selected.product = variant

  $scope.isSelected = (variant) ->
    variant.id is $scope.selected.product.id

  $scope.inCart = ->
    Cart.hasVariant($scope.selected.product)

  $scope.changeImage = (image) ->
    $scope.selected.image = image
