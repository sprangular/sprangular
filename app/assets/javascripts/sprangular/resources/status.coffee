Sprangular.service "Status", ->

  status =

    pageTitle: "Home"
    bodyClass: "default"
    requestedPath: null
    httpLoading: false
    routeChanging: false

    isLoading: ->
      @httpLoading || @routeChanging
