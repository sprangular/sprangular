Sprangular.factory "Address", ($q, $http, _, Env) ->

  class Sprangular.Address

    constructor: (attributes = {}) ->
      @setAttributes attributes
      @countryId = Env.config.default_country_id

    setAttributes: (attributes = {}) ->
      angular.extend this, attributes

    serialize: ->
      firstname: @firstname
      lastname: @lastname
      address1: @address
      city: @city
      phone: @phone
      zipcode: @zipcode
      state_id: @stateId
      country_id: @countryId

    equals: (otherAddress) ->
      _.isEqual(@serialize(), otherAddress.serialize())

    this.load = (address = {}) ->
      new Sprangular.Address
        id: address.id
        firstname: address.firstname
        lastname: address.lastname
        address: address.address1
        city: address.city
        phone: address.phone
        zipcode: address.zipcode
        stateId: address.state_id
        countryId: address.country_id

    this.getCountryList = ->
      $http.get('/countries', cache: true)
           .then (response) -> response.data
