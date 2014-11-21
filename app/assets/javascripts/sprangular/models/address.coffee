'use strict'

class Sprangular.Address
  Validity.define @,
    firstname: 'required'
    lastname: 'required'
    address1: 'required'
    city: 'required'
    state: 'required'
    country: 'required'
    zipcode: 'required'
    phone: 'required'

  init: ->
    @stateId = @state_id
    @countryId = @country_id

  fullName: ->
    "#{@firstname} #{@lastname}"

  serialize: ->
    id: @id
    firstname: @firstname
    lastname: @lastname
    address1: @address1
    address2: @address2
    city: @city
    phone: @phone
    zipcode: @zipcode
    state_id: @stateId
    country_id: @countryId

  same: (other) ->
    @firstname == other.firstname &&
      @lastname == other.lastname &&
      @address1 == other.address1 &&
      @address2 == other.address2 &&
      @city == other.city &&
      @phone == other.phone &&
      @zipcode == other.zipcode &&
      @countryId == other.countryId &&
      @stateId == other.stateId
