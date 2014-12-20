Sprangular.controller 'ProductCtrl', ($scope, Status, product, Account, Cart) ->
  $scope.product = product
  $scope.user = Account.user
  $scope.adding = false
  $scope.selected =
    image: null
    images: []
    quantity: 1
    variant: null

  if !product.hasVariants
    $scope.selected.variant = product.master

  Status.pageTitle = $scope.product.name

  $scope.$watch 'selected.variant', (variant) ->
    if variant && variant.images.length > 0
      $scope.selected.images = variant.images
    else
      $scope.selected.images = product.images

    $scope.selected.image = $scope.selected.images[0]

  $scope.changeQuantity = (val) ->
    $scope.selected.quantity = val

  $scope.changeImage = (image) ->
    $scope.selected.image = image

  $scope.hasVariant = ->
    Cart.hasVariant($scope.selected.variant)
