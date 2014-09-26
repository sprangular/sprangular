class Sprangular.Address
  init: ->
    @stateId = @state_id
    @countryId = @country_id

  serialize: ->
    firstname: @firstname
    lastname: @lastname
    address1: @address
    city: @city
    phone: @phone
    zipcode: @zipcode
    state_id: @stateId
    country_id: @countryId
