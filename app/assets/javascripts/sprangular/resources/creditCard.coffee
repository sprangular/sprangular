Sprangular.factory 'CreditCard', () ->

  class Sprangular.CreditCard
    # id, name, lastDigits, month, year, token, ccType, ccName, number, cvc

    this.nameToType =
      'MasterCard': 'master'
      'Visa': 'visa'
      'American Express': 'amex'
      'Discover': 'discover'
      'Diners Club': 'dinersclub'
      'JCB': 'jcb'

    this.typeToName =
      'master': 'MasterCard'
      'visa': 'Visa'
      'amex': 'American Express'
      'discover': 'Discover'
      'dinersclub': 'Diners Club'
      'jcb': 'JCB'

    constructor: (attributes = {}) ->
      @setAttributes attributes

    setAttributes: (attributes = {}) ->
      angular.extend this, attributes

      if @ccType and @ccType.length > 0
        @ccName = Sprangular.CreditCard.typeToName[@ccType]
      else if @ccName and @ccName.length > 0
        @ccType = Sprangular.CreditCard.nameToType[@ccName]

    this.load = (paymentSource = {}) ->
      new Sprangular.CreditCard
        id: paymentSource.id
        name: paymentSource.name
        lastDigits: paymentSource.last_digits
        month: paymentSource.month
        year: paymentSource.year
        token: paymentSource.gateway_payment_profile_id
        ccType: paymentSource.cc_type


    isNew: ->
      not (@token and @token.length > 0)

    fillWithDummyData: ->
      @setAttributes
        name: 'Visa Test'
        number: '4012888888881881'
        cvc: '123'
        month: '05'
        year: '2015'
        ccType: 'visa'

    serialize: ->
      name: @name
      last_digits: @lastDigits
      month: @month
      year: @year
      token: @token
      cc_type: @ccType
