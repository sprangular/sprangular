'use strict'

class Sprangular.CreditCard
  this.TYPES =
    master: 'MasterCard'
    visa: 'Visa'
    amex: 'American Express'
    discover: 'Discover'
    dinersclub: 'Diners Club'
    jcb: 'JCB'

  constructor: ->
    @number = ''
    @name = null
    @month = null
    @year = null
    @cvv = ''
    @type = null
    @token = null
    @lastDigits = null

  init: (attributes) ->
    @id = paymentSource.id
    @name = paymentSource.name
    @lastDigits = paymentSource.last_digits
    @month = paymentSource.month
    @year = paymentSource.year
    @token = paymentSource.gateway_payment_profile_id
    @type = paymentSource.cc_type

  isNew: ->
    not (@token and @token.length > 0)

  determineType: ->
    @type = switch @number[0]
      when '4'
        'Visa'
      when '5'
        'Master Card'

  serialize: ->
    name: @name
    last_digits: @lastDigits
    month: @month
    year: @year
    token: @token
    cc_type: @type
