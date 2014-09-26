class Sprangular.User
  init: ->
    @_mergeAddressLists()

  _mergeAddressLists: ->
    addresses = []
    unique = (address) -> addresses[address.id] = Sprangular.extend(address, Sprangular.Address)

    _.each @shipping_addresses, unique
    _.each @billing_addresses, unique

    @addresses = _.values(addresses)
