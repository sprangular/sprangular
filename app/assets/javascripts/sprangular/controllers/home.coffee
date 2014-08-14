Sprangular.controller 'HomeCtrl', ($scope, Status, Catalog, Cart) ->

  Catalog.fetch().then (catalog) ->
    Status.pageTitle = "Homepage"
    Status.bodyClass = "p-home"
    window.prerenderReady = true
