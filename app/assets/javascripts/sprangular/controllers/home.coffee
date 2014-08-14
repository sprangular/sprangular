Sprangular.controller 'HomeCtrl', ($scope, $stateParams, Status, Catalog, Cart) ->

  Catalog.fetch().then (catalog) ->
    Status.pageTitle = "Homepage"
    Status.bodyClass = "p-home"
    window.prerenderReady = true
