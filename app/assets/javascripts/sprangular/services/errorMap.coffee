Sprangular.service 'ErrorMap', (_) ->

  service =
    mapping:
      "An error occurred while processing your card. Try again in a little bit.": "An error occurred while processing your card. Try again in a little bit.  Sorry about that."
      "Your card's security code is incorrect.": "Your card's security code is incorrect."
      "Your card has expired.": "Your card has expired."
      "Your card was declined.": "Your card was declined."
      "Your card was declined. Please use another card.": "Your card was declined. Please use another card."
      "You must specify an API key.": "Oops! Something has gone wrong. Please contact us."
      "Invalid resource. Please fix errors and try again.": "Please review the info provided in the form."
      "exp_month invalid_number": "The card's expiration month is invalid."
      "exp_month invalid_expiry_month": "The card has expired."
      "exp_year invalid_number": "The card's expiration year is invalid."
      "exp_year invalid_expiry_year": "The card has expired."
      "number invalid_number": "The card number is incorrect."
      "number incorrect_number": "The card number is incorrect."
      "cvc": "The card's expiration month is invalid."
      "has already been taken": "Your email address has already been submitted for this gift."

    match: (string) ->
      @mapping[string] || string

    map: (message) ->
      if Array.isArray(message)
        _.map message, (v, k) -> service.match(v)
      else
        @match(message)

  service
