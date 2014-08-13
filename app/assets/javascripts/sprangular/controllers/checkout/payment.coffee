Sprangular.controller 'CheckoutPaymentCtrl', ($scope, $state, Account, Wallet, Checkout) ->
  $scope.wallet = null
  $scope.selectedCard = null
  $scope.newCreditCard = {}
  $scope.addingNewCard = false
  $scope.paymentMethod = PAYMENT_METHODS['stripe']

  Account.fetch().then (account) ->
    $scope.wallet = account.wallet
    Checkout.fetchContent().then (content) ->
      if content.order.payments and content.order.payments.length > 0
        payment = _.where(content.order.payments, {state: 'checkout'})[0]
        if payment
          sourceId = payment.source.id
          $scope.selectedCard = $scope.wallet.findCardForSource sourceId
      $scope.selectedCard ||= $scope.wallet.cards[0]
      if !$scope.selectedCard
        $scope.enterNewCard()

  $scope.useCard = (card) ->
    $scope.selectedCard = card

  $scope.enterNewCard = ->
    $scope.newCreditCard = Wallet.newCard()
    $scope.addingNewCard = true

  $scope.addNewCard = ->
    $scope.wallet.store $scope.newCreditCard, (addedCard) ->
      console.log 'success'
      $scope.addingNewCard = false
      $scope.useCard addedCard
    , (error) ->
      console.log 'error'
      $scope.addingNewCard = false

  $scope.fillDummyData = ->
    $scope.newCreditCard.fillWithDummyData()

  $scope.advance = ->
    Checkout.setPayment($scope.selectedCard, $scope.paymentMethod.id).then (content) ->
      Checkout.fetchContent().then (content) ->
        $scope.refreshContent()
        $state.go('checkout.confirm')
