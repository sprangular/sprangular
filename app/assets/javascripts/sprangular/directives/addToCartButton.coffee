'use strict'

Sprangular.directive 'addToCartButton', ->
  restrict: 'E'
  templateUrl: 'directives/add_to_cart_button.html'
  scope:
    variant: '='
    quantity: '='
    product: '='
    class: '='

  controller: ($scope, Cart) ->
    $scope.adding = false

    $scope.inCart = ->
      Cart.current.hasVariant($scope.variant)

    $scope.addToCart = ->
      $scope.adding = true

      Cart.addVariant($scope.variant, $scope.quantity)
        .success ->
          $scope.adding = false
          $scope.$emit('cart.add', {variant: $scope.variant, qty: $scope.quantity})
