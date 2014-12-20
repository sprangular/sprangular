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
    cvc: ['required', length: {greaterThan: 2, lessThan: 5}]

  constructor: ->
    @number = ''
    @name = null
    @month = null
    @year = null
    @cvc = null
    @type = null
    @token = null
    @lastDigits = null

  init: (attributes) ->
    @id = attributes.id
    @name = attributes.name
    @lastDigits = attributes.last_digits
    @month = attributes.month
    @year = attributes.year
    @token = attributes.gateway_payment_profile_id
    @type = attributes.cc_type

  isNew: ->
    not (@token and @token.length > 0)

  label: ->
    "#{@constructor.TYPE_NAMES[@type]} XXXX-XXXX-XXXX-#{@lastDigits}"

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

  same: (other) ->
    @id == other.id

  _validateCardFormat: ->
    'invalid card number' unless Sprangular.Luhn.isValid(@number)
