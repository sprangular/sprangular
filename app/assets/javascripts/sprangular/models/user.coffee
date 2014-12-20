class Sprangular.User
  init: ->
    @creditCards = []
    @_mergeAddressLists()
    @orders = Sprangular.extend(@orders, Sprangular.Order)

    for paymentSource in @payment_sources
      card = new Sprangular.CreditCard
      card.init(paymentSource)

      @creditCards.push(card)

    @allowOneClick = @creditCards.length > 0 && @addresses.length > 0

  _mergeAddressLists: ->
    addresses = []
    unique = (address) -> addresses[address.id] = Sprangular.extend(address, Sprangular.Address)

    _.each @shipping_addresses, unique
    _.each @billing_addresses, unique

    @addresses = _.values(addresses)
