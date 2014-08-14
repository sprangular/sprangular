Sprangular.controller 'CheckoutCtrl', ($window, $scope, $rootScope, $location, Status, Account, Cart, Checkout) ->

  $scope.isLogged = false

  Cart.fetch().then (cart) ->
    Account.fetch().then (account) ->
      if account.isLogged
        Checkout.init cart.number
        Checkout.fetchContent().then (content) ->
          $scope.order = content.order
          $scope.routerInit()
      else
        $window.scrollTo(0,0)
        $location.path '/sign-in'

  $scope.refreshContent = ->
    Checkout.fetchContent().then (content) ->
      $scope.order = content.order

  $scope.advanceCart = ->
    Checkout.next().then (content) ->
      Checkout.fetchContent().then (content) ->
        $scope.order = content.order
        $scope.routerInit()

  $scope.routerInit = () ->
    if $scope.order.state is 'cart' then $scope.advanceCart()
    else $scope.routerCheck()

  $scope.routerCheck = ->
    params =
      location: true
      notify: true

    switch $scope.order.state
      when 'address'
        $location.path '/checkout/shipping', params
      when 'delivery'
        if $scope.order.bill_address == null
          $location.path '/checkout/billing', params
        else
          $location.path '/checkout/delivery', params
      when 'payment'
        $location.path '/checkout/payment', params
      when 'confirm'
        $location.path '/checkout/confirm', params
      when 'complete'
        $location.path '/checkout/complete', params
      else
        $location.path '/checkout', params
