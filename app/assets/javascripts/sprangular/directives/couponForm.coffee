Sprangular.directive 'couponForm', ->
  restrict: 'E'
  templateUrl: 'coupons/form.html'
  scope:
    order: '='
  controller: ($scope) ->
    $scope.showCouponEntry = false
