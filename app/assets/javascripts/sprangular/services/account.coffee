Sprangular.service "Account", ($http, _, $q, Cart, Flash, $translate) ->

  service =

    fetched: false
    isLogged: false
    isGuest: false

    init: ->
      @clear()

      startupData = Sprangular.startupData

      if startupData.User
        service.populateAccount(startupData.User)
        service.fetched = true
      else
        $http.get('/api/account')
          .success (data) ->
            service.populateAccount(data)
            service.fetched = true
          .error (data) ->
            service.isLogged = false
            service.fetched = true

    reload: ->
      @fetched = false
      $http.get('/api/account')
        .success (data) ->
          service.populateAccount(data)
          service.fetched = true
        .error (data) ->
          service.isLogged = false

    populateAccount: (data) ->
      @user = Sprangular.extend(data, Sprangular.User)
      Cart.load(@user.current_order)
      @isLogged = true
      @email = data.email

    populateGuestAccount: (data) ->
      @isGuest = true
      @email = data.email

    clear: ->
      @fetched = false
      @user = {}
      @isLogged = false
      @email = null

    guestLogin: (data) ->
      params =
        'order[email]': data.email
      $http.post('/api/cart/guest_login.json', $.param(params))
        .success (data) ->
          service.populateGuestAccount(data)
          Flash.success 'app.signed_in'
        .error ->
          Flash.error 'app.signin_failed'

    login: (data) ->
      params =
        'spree_user[email]': data.email,
        'spree_user[password]': data.password
      $http.post('/spree/login.json', $.param(params))
        .success (data) ->
          service.populateGuestAccount(data.email)
          Flash.success 'app.signed_in'
        .error ->
          Flash.error 'app.signin_failed'

    logout: ->
      $http.get('/spree/logout')
        .success (data) ->
          service.isLogged = false
          service.clear()
          Cart.init()

    signup: (data) ->
      params =
        spree_user: data

      $http.post('/api/account', $.param(params))
        .success (data) ->
          service.populateAccount(data)

    forgotPassword: (data) ->
      params =
        spree_user: data
      $http.post('/api/passwords', $.param(params))
        .success (data) ->
          service.reload()

    resetPassword: (data) ->
      params =
        spree_user: data
      $http.put('/api/passwords/'+data.reset_password_token, $.param(params))
        .success (data) ->
          service.reload()

    save: (data) ->
      params =
        spree_user: data.serialize()
      $http.put('/api/account', $.param(params))
        .success (data) ->
          service.populateAccount(data)
          Flash.success 'app.account_updated'
        .error ->
          Flash.error 'app.account_update_failed'

    deleteCard: (card) ->
      cards = @user.creditCards

      $http.delete("/api/credit_cards/#{card.id}")
        .success (data) ->
          i = cards.indexOf card
          cards.splice(i, 1) unless i is -1

  service.init()
  service
