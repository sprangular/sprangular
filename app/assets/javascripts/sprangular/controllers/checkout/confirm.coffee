Sprangular.controller 'CheckoutConfirmCtrl', ($scope, $location, Account, Cart, Checkout) ->

  $scope.advance = ->
    Checkout.confirm().then (content) ->
      Checkout.fetchContent().then (content) ->
        $location.path('/checkout/complete')
