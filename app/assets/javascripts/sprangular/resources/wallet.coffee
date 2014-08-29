Sprangular.service 'Wallet', ($q, $http, CreditCard, StripeService) ->

  Wallet =

    cards: []
    loaded: false

    newCard: (attributes) ->
      new CreditCard(attributes)

    # Load credit cards from account
    load: (account) ->
      @cards.length = 0
      for paymentSource in account.payment_sources
        @cards.push CreditCard.load(paymentSource)
      @loaded = true

    findCardForSource: (sourceId) ->
      for card in @cards
        return card if card.id is sourceId

    # Stores card in Stripe repository, and get an access token
    store: (card, successCallback, errorCallback) ->
      # TODO: provide billing address as well
      card.error = card.token = ''
      cards = @cards
      StripeService.sendToStripe(card)
        .then (response) ->
          card.setAttributes
            token: response.id
            lastDigits: response.card.last4
            month: response.card.exp_month
            year: response.card.exp_year
            ccName: response.card.type
          cards.push card
          successCallback(card)
        , (error) ->
          card.error = error.message
          errorCallback(error)

    delete: (card) ->
      deferred = $q.defer()
      cards = @cards
      $http.delete("/api/credit_cards/#{card.id}")
        .success (data) ->
          i = cards.indexOf card
          cards.splice(i, 1) unless i is -1
          deferred.resolve Wallet
        .error (error) ->
          deferred.reject error

