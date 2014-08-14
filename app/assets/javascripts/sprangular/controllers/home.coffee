Sprangular.controller 'HomeCtrl', ($scope, $stateParams, Status, Catalog, Cart) ->

  Catalog.fetch().then (catalog) ->
    Status.pageTitle = "Sprangular Homepage"
    Status.bodyClass = "p-home"
    window.prerenderReady = true
