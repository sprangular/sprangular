Sprangular.controller 'ProductCtrl', ($scope, Status, product, Cart) ->
  $scope.product = product
  $scope.adding = false
  $scope.selected =
    image: product.variants[0].images[0]
    quantity: 1
    variant: null

  if !product.hasVariants
    $scope.selected.variant = product.master

  Status.pageTitle = $scope.product.name

  $scope.$watch 'selected.variant', (variant) ->
    $scope.selected.image = variant.images[0] if variant

  $scope.changeQuantity = (val) ->
    $scope.selected.quantity = val

  $scope.changeImage = (image) ->
    $scope.selected.image = image

  $scope.hasVariant = ->
    Cart.hasVariant($scope.selected.variant)
