Sprangular.controller 'ProductCtrl', ($scope, Status, product, Cart) ->
  $scope.product = product
  $scope.adding = false
  $scope.selected =
    image: product.master.images[0]
    quantity: 1
    variant: null
    values: {}

  if !product.hasVariants
    $scope.selected.variant = product.master

  Status.pageTitle = $scope.product.name

  $scope.isValueSelected = (value) ->
    $scope.selected.values[value.option_type_id]?.id == value.id

  $scope.isValueAvailable = (value) ->
    product.availableValues(_.values($scope.selected.values))

  $scope.selectValue = (value) ->
    selected = $scope.selected
    selected.values[value.option_type_id] = value
    selected.variant = product.variantForValues(_.values(selected.values))

  $scope.changeQuantity = (val) ->
    $scope.selected.quantity = val

  $scope.addToCart = ->
    selected = $scope.selected
    $scope.adding = true

    Cart.addVariant(selected.variant, selected.quantity)
      .success ->
        $scope.adding = false
        $scope.$emit('cart.add', {variant: selected.variant, qty: selected.quantity})

  $scope.selectVariant = (variant) ->
    $scope.selected.variant = variant

  $scope.isSelected = (variant) ->
    variant.id is $scope.selected.variant.id

  $scope.inCart = ->
    Cart.hasVariant($scope.selected.variant)

  $scope.changeImage = (image) ->
    $scope.selected.image = image
