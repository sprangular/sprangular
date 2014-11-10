Sprangular.directive 'promoForm', ->
  restrict: 'E'
  templateUrl: 'promos/form.html'
  scope:
    order: '='
  controller: ($scope, Cart, Checkout, Angularytics) ->
    $scope.showPromoEntry = false
    $scope.promoCode = ''

    $scope.save = ->
      Cart.current.promoCode = $scope.promoCode
      Angularytics.trackEvent("Cart", "Coupon added", $scope.promoCode)

      error = (message) ->
        $scope.promoCode = ''
        $scope.error = message

      Checkout.savePromo($scope.promoCode)
        .success (response) ->
          if response.error
            error(response.error)
          else
            $scope.showPromoEntry = false
        .error ->
          error('An error occured')
