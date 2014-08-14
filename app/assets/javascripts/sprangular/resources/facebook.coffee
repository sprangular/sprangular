Sprangular.service 'Facebook', ($q, $http, Env) ->

  accessToken = null

  # Load the Facebook SDK Asynchronously
  ((d) ->
    js = undefined
    id = "facebook-jssdk"
    ref = d.getElementsByTagName("script")[0]
    return  if d.getElementById(id)
    js = d.createElement("script")
    js.id = id
    js.async = true
    js.src = "//connect.facebook.net/en_US/all.js"
    ref.parentNode.insertBefore js, ref
    return
  ) document

  window.fbAsyncInit = ->
    Facebook.init()
    return

  Facebook =

    init: ->
      FB.init
        appId: Env.config.facebook_app_id # App ID
        channelUrl: "//localhost:3000/channel.html" # Channel File
        status: false # check login status
        cookie: false # enable cookies to allow the server to access the session
        xfbml: true # parse XFBML

    login: (email) ->
      deferred = $q.defer()
      service = this
      if accessToken
        # We use the FB api to check if the persisted token is still authorized.
        # The user could have removed the app while we still have the token in memory.
        # The FB login page does not handle this properly.  Solution: call init() again
        # and log back in.

        # Check if accessToken still valid.
        FB.api '/me', (response) ->
          if response.error
            # Not valid anymore, reinitialize and do the Login
            service.init()
            service.fbLogin deferred, email
          else
            # Token valid, no need to login again, let's fetch the
            # user from the server.
            service.fetchUser deferred, email
      else
        service.fbLogin deferred, email

      return deferred.promise

    fbLogin: (deferred, email) ->
      service = this
      FB.login ((response) ->
        console.log response
        if response.authResponse
          accessToken = response.authResponse
          service.fetchUser deferred, email
        else
          deferred.reject
            facebookError: true
            response: response
        return
      ),
        scope: "email"

    status: ->
      deferred = $q.defer()
      FB.getLoginStatus (response) ->
        deferred.resolve response.status

    fetchUser: (deferred, email) ->
      accessToken.email = email
      $http.post("/facebook/fetch", $.param(accessToken))
        .success (data) ->
          deferred.resolve data
        .error (data, status) ->
          deferred.reject
            facebookError: false
            data: data
            status: status

