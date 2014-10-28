Sprangular.service 'StripeService', ($q) ->
  service =
    sendToStripe: (card) ->
      deferred = $q.defer()

      Stripe.card.createToken
          number: card.number
          cvc: card.cvc
          exp_month: card.month
          exp_year: card.year
        , (status, response) ->
          console.log response
          if response.error
            deferred.reject response.error
          else
            deferred.resolve response

      return deferred.promise

  service
