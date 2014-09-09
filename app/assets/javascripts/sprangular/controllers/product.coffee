Sprangular.controller 'ProductCtrl', ($scope, Status, product, Cart) ->
  $scope.product = product
  $scope.adding = false
  $scope.selected =
    image: product.variants[0].images[0]
    quantity: 1
    variant: null
    values: {}

  if !product.hasVariants
    $scope.selected.variant = product.master

  Status.pageTitle = $scope.product.name

  $scope.$watch 'selected.variant', (variant) ->
    $scope.selected.image = variant.images[0]

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

  $scope.selectVariant = (variant) ->
    $scope.selected.variant = variant

  $scope.isSelected = (variant) ->
    variant.id is $scope.selected.variant.id

  $scope.changeImage = (image) ->
    $scope.selected.image = image
