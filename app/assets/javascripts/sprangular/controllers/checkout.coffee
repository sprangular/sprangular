Sprangular.controller 'CheckoutCtrl', ($window, $scope, $rootScope, $state, Status, Account, Cart, Checkout) ->

  # $rootScope.$on '$stateChangeStart', (event, toState, fromState) ->
  #   console.log event.name
  #   console.log "-- $state.includes", $state.includes('checkout')
  #   console.log "-- toState", toState.name

  # $rootScope.$on '$stateChangeSuccess', (event, toState, fromState) ->
  #   console.log event.name
  #   console.log "-- $state.includes", $state.includes('checkout')
  #   console.log "-- fromState", fromState.name

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
        $state.go 'gateKeeper',
          nextState: 'checkout'
        ,
          location: false
          notify: true

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
        $state.go 'checkout.shipping', params
      when 'delivery'
        if $scope.order.bill_address == null
          $state.go 'checkout.billing', params
        else
          $state.go 'checkout.delivery', params
      when 'payment'
        $state.go 'checkout.payment', params
      when 'confirm'
        $state.go 'checkout.confirm', params
      when 'complete'
        $state.go 'checkout.complete', params
      else
        $state.go 'checkout', params
