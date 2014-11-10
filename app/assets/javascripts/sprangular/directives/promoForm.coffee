Sprangular.directive 'promoForm', ->
  restrict: 'E'
  templateUrl: 'promos/form.html'
  scope:
    order: '='
  controller: ($scope, Cart, Checkout) ->
    $scope.showPromoEntry = false
    $scope.promoCode = Cart.current.promoCode

    $scope.save = ->
      Cart.current.promoCode = $scope.promoCode

      error = (message) ->
        $scope.promoCode = ''
        $scope.error = message

      Checkout.savePromo()
        .success (response) ->
          if response.error
            error(response.error)
          else
            $scope.showPromoEntry = false
        .error ->
          error('An error occured')
