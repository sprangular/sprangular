Sprangular.factory "Address", ($q, $http, _) ->

  class Sprangular.Address

    constructor: (attributes = {}) ->
      @setAttributes attributes
      @countryId = Sprangular.Address.countryId

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
      country = [] #<%= Spree::Country.find_by_iso3('USA').to_json %>

    this.getStatesList = ->
      states = [] #<%= Spree::Country.find_by_iso3('USA').states.order('name').map { |s| { name: s.name, id: s.id } }.to_json %>

    this.countryId = null #<%= Spree::Country.find_by_iso3('USA').id %>


