Sprangular.controller 'ProductCtrl', ($scope, $stateParams, Status, Catalog, Cart) ->

  Catalog.fetch().then (catalog) ->
    query = { slug: $stateParams.id }
    $scope.product = catalog.findProduct query
    if $stateParams.id isnt "glossier-phase-i"
      $scope.callout =
        product: catalog.findProduct { slug: "glossier-phase-i" }
        variant: catalog.findProduct({ slug: "glossier-phase-i" }).variants[0]
    $scope.selected =
      product: $scope.product.variants[0]
      quantity: 1
    Status.pageTitle = $scope.product.name
    Status.bodyClass = "p-prod--show"
    $scope.prev = catalog.findSibling -1, { id: $scope.product.id }
    $scope.next = catalog.findSibling 1, { id: $scope.product.id }
    window.prerenderReady = true

  $scope.changeQuantity = (val) ->
    $scope.selected.quantity = val

  $scope.addToCart = (variant, qty) ->
    Cart.addVariant variant, qty

  $scope.updateQuantity = (delta) ->
    # if $scope.selected.quantity <= 0 or $scope.selected.quantity is NaN or $scope.selected.quantity is undefined
    #   $scope.selected.quantity = 0
    # else
    $scope.selected.quantity += delta unless ($scope.selected.quantity + delta) is 0

  $scope.selectVariant = (variant) ->
    $scope.selected.product = variant

  $scope.isSelected = (variant) ->
    variant.id is $scope.selected.product.id
