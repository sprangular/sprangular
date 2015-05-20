Sprangular.directive 'promoForm', ->
  restrict: 'E'
  templateUrl: 'promos/form.html'
  scope:
    order: '='
  controller: ($scope, Cart, Checkout, Angularytics) ->
    $scope.showPromoEntry = false
    $scope.promoCode = ''

    $scope.reset = ->
      $scope.promoCode = ''
      $scope.showPromoEntry = false

    $scope.save = ->
      Checkout.savePromo($scope.promoCode)
        .then ->
          Angularytics.trackEvent("Cart", "Coupon added", $scope.promoCode)
          $scope.reset()

        , (response) ->
          Cart.current.loading = false
          $scope.promoCode = ''
          $scope.error = response.error
