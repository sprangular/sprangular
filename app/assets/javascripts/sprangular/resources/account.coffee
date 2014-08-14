Sprangular.service "Account", ($http, _, $q, Wallet, Address, Cart) ->

  fetchDefer = $q.defer()

  service =

    fetched: false
    account: {}
    isLogged: false
    email: null
    wallet: null
    orders: []
    shippingAddresses: []
    billingAddresses: []
    flash: null

    init: ->
      @fetched = false
      $http.get '/account'
        .success (data) ->
          service.populateAccount(data)
          fetchDefer.resolve service
          service.fetched = true
        .error (data) ->
          service.isLogged = false
          service.fetched = true
          fetchDefer.resolve service

    reload: ->
      deferred = $q.defer()
      @fetched = false
      $http.get '/account'
        .success (data) ->
          service.populateAccount(data)
          Cart.reload()
          service.fetched = true
          deferred.resolve service
        .error (data) ->
          service.fetched = true
          service.isLogged = false
          deferred.resolve service
      return deferred.promise

    populateAccount: (data) ->
      @account = data
      @isLogged = true
      @email = data.email
      @wallet = Wallet
      @wallet.load(@account)
      @shippingAddresses.length = 0
      @billingAddresses.length = 0
      @orders = data.orders
      for address in @account.shipping_addresses
        @shippingAddresses.push Address.load(address)
      for address in @account.billing_addresses
        @billingAddresses.push Address.load(address)

    login: (data) ->
      deferred = $q.defer()
      params =
        'spree_user[email]': data.email,
        'spree_user[password]': data.password
      $http.post '/spree/login.js', $.param params
        .success (data) ->
          service.reload().then (data) ->
            Cart.reload()
            deferred.resolve service
        .error (response) ->
          deferred.reject response.error
      return deferred.promise

    logout: ->
      deferred = $q.defer()
      $http.get '/spree/logout'
        .success (data) ->
          service.isLogged = false
          Cart.reload()
          deferred.resolve service
        .error (error) ->
          deferred.reject error
      return deferred.promise

    signup: (data) ->
      deferred = $q.defer()
      params =
        spree_user: data
      $http.post '/account', $.param params
        .success (data) ->
          service.reload().then (data) ->
            Cart.reload()
            deferred.resolve service
        .error (response) ->
          deferred.reject response.errors
      return deferred.promise

    forgotPassword: (data) ->
      deferred = $q.defer()
      params =
        spree_user: data
      $http.post '/passwords', $.param params
        .success (data) ->
          service.reload().then (data) ->
            Cart.reload()
            deferred.resolve service
        .error (response) ->
          deferred.reject response.errors
      return deferred.promise

    resetPassword: (data) ->
      deferred = $q.defer()
      params =
        spree_user: data
      $http.put '/passwords/'+data.reset_password_token, $.param params
        .success (data) ->
          service.reload().then (data) ->
            Cart.reload()
            deferred.resolve service
        .error (response) ->
          deferred.reject response.errors
      return deferred.promise

    save: (data) ->
      deferred = $q.defer()
      params =
        spree_user: data
      $http.put '/account', $.param params
        .success (data) ->
          service.reload().then (data) ->
            service.flash = 'Account updated'
            deferred.resolve service
        .error (response) ->
          deferred.reject response.errors
      return deferred.promise


    fetch: ->
      return fetchDefer.promise

  service.init()
  service
