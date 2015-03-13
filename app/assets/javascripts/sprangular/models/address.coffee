'use strict'

class Sprangular.Address
  Validity.define @,
    # firstname: 'required'
    # lastname: 'required'
    name: 'required'
    address1: 'required'
    city: 'required'
    state: 'required'
    country: 'required'
    zipcode: 'required'
    phone: 'required'

  init: ->
    @name = @fullName()
    @stateId = @state_id
    @countryId = @country_id

  fullName: ->
    "#{@firstname} #{@lastname}"

  shortAddress: ->
    "#{@fullName()}, #{@addressLine()}, #{@city} #{@actualStateName()}, #{@zipcode}"

  actualStateName: ->
    @state?.abbr || @state_name

  addressLine: ->
    if @address2
      @address1 + " " + @address2
    else
      @address1

  usingFullName: ->
    @name && @name.length > 0      

  getFirstname: ->
    return @name.split(' ').slice(0, -1).join(' ') if @usingFullName()
    @firstname

  getLastname: ->
    return @name.split(' ').slice(-1).join(' ') if @usingFullName()
    @lastname

  serialize: ->        
    firstname: @getFirstname()
    lastname: @getLastname()    
    address1: @address1
    address2: @address2
    city: @city
    phone: @phone
    zipcode: @zipcode
    state_id: @stateId
    country_id: @countryId

  isEmpty: ->
    !@firstname &&
    !@lastname &&
    !@address1 &&
    !@address2 &&
    !@city &&
    !@phone &&
    !@zipcode &&
    !@countryId &&
    !@stateId

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

  key: ->
    [@firstname,
     @lastname,
     @address1,
     @address2,
     @city,
     @phone,
     @zipcode,
     @countryId,
     @stateId].join('')
