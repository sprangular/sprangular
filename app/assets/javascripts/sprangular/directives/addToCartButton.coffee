'use strict'

Sprangular.directive 'addToCartButton', ->
  restrict: 'E'
  templateUrl: 'directives/add_to_cart_button.html'
  scope:
    variant: '='
    quantity: '='
    product: '='
    options: '='
    class: '='

  controller: ($scope, Cart, Angularytics, Env) ->
    $scope.adding = false
    $scope.currencySymbol = Env.config.currency.symbol

    $scope.inCart = ->
      Cart.current.hasVariant($scope.variant)

    $scope.addToCart = ->
      $scope.adding = true
      Angularytics.trackEvent("Cart", "Add", $scope.variant.product.name)

      Cart.addVariant($scope.variant, $scope.quantity, $scope.options)
        .success ->
          $scope.adding = false
          $scope.$emit('cart.add', {variant: $scope.variant, qty: $scope.quantity, options: $scope.options})
