Sprangular.controller 'CheckoutConfirmCtrl', ($scope, $state, Account, Cart, Checkout, Product) ->

  $scope.advance = ->
    Checkout.confirm().then (content) ->
      Checkout.fetchContent().then (content) ->
        $state.go('checkout.complete')
