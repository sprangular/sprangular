'use strict'

class Sprangular.CreditCard
  this.TYPE_NAMES =
    master: 'MasterCard'
    visa: 'Visa'
    amex: 'American Express'
    discover: 'Discover'
    dinersclub: 'Diners Club'
    jcb: 'JCB'

  Validity.define @,
    number: ['required', '_validateCardFormat']
    month: 'required'
    year: 'required'
    cvv: ['required', length: {greaterThan: 2, lessThan: 5}]

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
    @type = if @number.match /^3[47]/
              'amex'
            else if @number.match /^4/
              'visa'
            else if @number.match /^5[1-5]/
              'master'
            else if @number.match /^6(5|011)/
              'discover'
            else if @number.match /^3(0[0-5]|36|38)/
              'dinersclub'
            else if @number.match /^(2131|1800|35)/
              'jcb'

  serialize: ->
    name: @name
    last_digits: @lastDigits
    month: @month
    year: @year
    token: @token
    cc_type: @type

  _validateCardFormat: ->
    'invalid card number' unless Sprangular.Luhn.isValid(@number)
