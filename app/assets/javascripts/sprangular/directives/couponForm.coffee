Sprangular.directive 'couponForm', ->
  restrict: 'E'
  templateUrl: 'coupons/form.html'
  scope:
    order: '='
  controller: ($scope, Cart, Checkout) ->
    $scope.showCouponEntry = false
    $scope.couponCode = Cart.current.couponCode

    $scope.remove = ->
      $scope.couponCode = ''
      $scope.save()

    $scope.save = ->
      Cart.current.couponCode = $scope.couponCode

      error = (message) ->
        $scope.couponCode = ''
        $scope.error = message

      Checkout.saveCoupon()
        .success (response) ->
          if response.error
            error(response.error)
          else
            $scope.showCouponEntry = false
        .error ->
          error('An error occured')
