Sprangular.controller 'ProductCtrl', ($scope, Status, product, Account, Cart) ->
  $scope.product = product
  $scope.user = Account.user
  $scope.adding = false
  $scope.selected =
    image: null
    images: []
    quantity: 1
    variant: null

  Status.pageTitle        = $scope.product.name
  Status.meta.title       = $scope.product.meta_title
  Status.meta.description = $scope.product.meta_description
  Status.meta.keywords    = $scope.product.meta_keywords

  $scope.selected.variant = if product.hasVariants
    Cart.current.findVariantForProduct(product) || product.firstAvailableVariant()
  else
    product.master

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
